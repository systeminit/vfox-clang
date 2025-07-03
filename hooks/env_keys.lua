function PLUGIN:EnvKeys(ctx)
    local mainPath = ctx.path

    local binPath = mainPath .. "/bin"
    local libclangPath = mainPath .. "/envs/libclang/lib"
    local lvm2IncludePath = mainPath .. "/envs/lvm2/include"
    local lvm2LibPath = mainPath .. "/envs/lvm2/lib"

    return {
        {
            key = "PATH",
            value = binPath,
        },
        {
            key = "LIBCLANG_PATH",
            value = libclangPath
        },
        {
            key = "CPATH",
            value = lvm2IncludePath
        },
        {
            key = "LIBRARY_PATH",
            value = lvm2LibPath
        }
    }
end
