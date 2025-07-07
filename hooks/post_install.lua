require("util")

function PLUGIN:PostInstall(ctx)
    local sdkInfo = ctx.sdkInfo["clang"]
    pixiInstall(sdkInfo.path, sdkInfo.version)

     -- Add clang++ symlink
    local bin_dir = sdkInfo.path .. "/bin"
    local clangpp = bin_dir .. "/clang++"
    local clang = bin_dir .. "/clang"

    -- Check if clang++ already exists
    local f = io.open(clangpp, "r")
    if f == nil then
        -- Symlink clang++ -> clang if missing
        os.execute(string.format("ln -sf %s %s", clang, clangpp))
    else
        f:close()
    end

     -- Write libdevmapper.pc
    local mainPath = sdkInfo.path
    local lvm2IncludePath = mainPath .. "/envs/lvm2/include"
    local lvm2LibPath = mainPath .. "/envs/lvm2/lib"
    local pcDir = lvm2LibPath .. "/pkgconfig"
    os.execute("mkdir -p " .. pcDir)

    local pcFile = pcDir .. "/libdevmapper.pc"
    local pc = io.open(pcFile, "w")
    if pc then
        pc:write([[
prefix=]] .. mainPath .. [[/envs/lvm2
exec_prefix=${prefix}
libdir=${exec_prefix}/lib
includedir=${prefix}/include

Name: libdevmapper
Description: Device Mapper Library
Version: 1.02.200
Libs: -L${libdir} -ldevmapper
Cflags: -I${includedir}
]])
        pc:close()
    else
        print("Failed to write libdevmapper.pc!")
    end
end
