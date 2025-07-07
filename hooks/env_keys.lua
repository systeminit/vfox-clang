function PLUGIN:EnvKeys(ctx)
    local mainPath = ctx.path

    local binPath = mainPath .. "/bin"
    local libclangPath = mainPath .. "/envs/libclang/lib"
    local lvm2LibPath = mainPath .. "/envs/lvm2/lib/pkgconfig"
    local lvm2Includes = "-I" .. mainPath .. "/envs/lvm2/include"

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
            key = "PKG_CONFIG_PATH",
            value = lvm2LibPath
        },
        {
            key = "BINDGEN_EXTRA_CLANG_ARGS",
            value = lvm2Includes
        }
    }
end
