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
end
