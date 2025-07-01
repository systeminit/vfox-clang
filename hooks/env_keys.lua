function PLUGIN:EnvKeys(ctx)
    local mainPath = ctx.path
    local libclangPath = mainPath .. "/envs/libclang/lib"
    return {
        {
            key = "PATH",
            value = mainPath .. "/bin"
        },
        {
            key = "LIBCLANG_PATH",
            value = libclangPath
        }
    }
end
