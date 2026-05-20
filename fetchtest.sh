rm -rf testout

packages=("alpinejs:3.15.3" "@alpinejs/focus:3.15.3" "@alpinejs/persist:3.15.3" "@hotwired/turbo:8.0.20")

# For each of the package:version in the array above, call fetch-npm-package <package> <version> testout/<package>
for entry in "${packages[@]}"; do
	package="${entry%%:*}"
	version="${entry##*:}"
	outDir="testout1/$package"
	mkdir -p $outDir
	fetch-npm-package "$package" "$version" $outDir
done
