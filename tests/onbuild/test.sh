
testOnbuild() {
	local testdir="$(dirname $BASH_SOURCE)"
	local image="test-$(basename $testdir)"
	for version in $VERSIONS; do
		echo $version
		echo "FROM python-runtime:$version" > "$testdir/Dockerfile"
		docker build -q -t "$image" "$testdir" > /dev/null

		local output="$(docker run --rm $image which wget 2> /dev/null)"
		assertEquals "wget is not installed" \
			"/usr/bin/wgett" "$output"
		
		docker rmi "$image" > /dev/null 2>&1
	done
}
