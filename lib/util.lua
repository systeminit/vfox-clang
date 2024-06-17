local ClangVersions = {
    "18.1.7",
    "18.1.6",
    "18.1.5",
    "18.1.4",
    "18.1.3",
    "18.1.2",
    "18.1.1",
    "17.0.6",
    "17.0.5",
    "17.0.4",
    "17.0.3",
    "17.0.2",
    "17.0.1",
    "16.0.6",
    "16.0.5",
    "16.0.4",
    "16.0.3",
    "16.0.2",
    "16.0.1",
    "16.0.0",
    "15.0.7",
    "15.0.6",
    "15.0.5",
    "15.0.4",
    "15.0.3",
    "15.0.2",
    "15.0.1",
    "15.0.0",
    "14.0.6",
    "14.0.5",
    "14.0.4",
    "14.0.3",
    "14.0.0",
    "13.0.1",
    "13.0.0",
    "12.0.1",
    "12.0.0",
    "11.1.0",
    "11.0.1",
    "11.0.0",
    "10.0.1",
    "10.0.0",
    "9.0.1",
}

function fetchAvailable(noCache)
    local result = {}

    if noCache then
        clearCache()
    end
    for i, v in ipairs(ClangVersions) do
        if i == 1 then
            table.insert(result, {
                version = v,
                note = "latest",
            })
        else
            table.insert(result, {
                version = v,
            })
        end
    end

    return result
end

function clearCache()
    os.remove(RUNTIME.pluginDirPath .. "/available.cache")
end

function getDownloadInfo(version)
    local file

    if version == "latest" then
        version = ClangVersions[1]
    end
    if not hasValue(ClangVersions, version) then
        print("Unsupported version: " .. version)
        os.exit(1)
    end
    file = generatePixi(RUNTIME.osType, RUNTIME.archType)

    return file, version
end

function hasValue(table, value)
    for _, v in ipairs(table) do
        if v == value then
            return true
        end
    end

    return false
end

function generatePixi(osType, archType)
    local file
    local githubURL = os.getenv("GITHUB_URL") or "https://github.com/"
    local releaseURL = githubURL:gsub("/$", "") .. "/prefix-dev/pixi/releases/"

    if archType == "arm64" then
        archType = "aarch64"
    elseif archType == "amd64" then
        archType = "x86_64"
    else
        print("Unsupported architecture: " .. archType)
        os.exit(1)
    end
    if osType == "macos" then
        file = "pixi-" .. archType .. "-apple-darwin.tar.gz"
    elseif osType == "linux" then
        file = "pixi-" .. archType .. "-unknown-linux-musl.tar.gz"
    elseif osType == "windows" and archType == "x86_64" then
        file = "pixi-" .. archType .. "-pc-windows-msvc.zip"
    else
        print("Unsupported environment: " .. osType .. "-" .. archType)
        os.exit(1)
    end
    file = releaseURL .. "latest/download/" .. file

    return file
end

function pixiInstall(path, version)
    local condaForge = os.getenv("Conda_Forge") or "conda-forge"
    local noStdout = RUNTIME.osType == "windows" and " > nul" or " > /dev/null"
    local pixi = RUNTIME.osType == "windows" and path .. "\\pixi.exe" or path .. "/pixi"
    local command = pixi .. " global install -qc " .. condaForge .. " clang=" .. version

    os.setenv("PIXI_HOME", path)
    local status = os.execute(command .. noStdout)
    if status ~= 0 then
        print("Failed to execute command: " .. command)
        os.exit(1)
    end
    os.remove(pixi)
end
