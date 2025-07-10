function PLUGIN:EnvKeys(ctx)
    local mainPath = ctx.path

    local binPath = mainPath .. "/bin"
    local libclangPath = mainPath .. "/envs/libclang/lib"
    local lvm2LibPath = mainPath .. "/envs/lvm2/lib/pkgconfig"
    local lvm2Includes = "-I" .. mainPath .. "/envs/lvm2/include"
    local sysroot = mainPath .. "/envs/clang/x86_64-conda-linux-gnu/sysroot"
    local clangInclude = mainPath .. "/envs/clang/lib/clang/20/include"
    local bindgenArgs = lvm2Includes .. " --sysroot=" .. sysroot .. " -I" .. clangInclude

    return {
        { key = "PATH", value = binPath },
        { key = "LIBCLANG_PATH", value = libclangPath },
        { key = "PKG_CONFIG_PATH", value = lvm2LibPath },
        { key = "BINDGEN_EXTRA_CLANG_ARGS", value = bindgenArgs },
    }
end
