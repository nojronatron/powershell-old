<#  Title: Make-BigFile.ps1
    Description: Uses Lorem Ipsum text to create a large file.
    Usage: .\Make-BigFile.ps1 -target_file <[path]\file.txt> -repetitions (1 to 10,000).
    Author: Jonathan Rumsey, Software Tester II
    Created: 9-Aug-2016
    Updated: (initial)
#>

Param (
    [parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage="Enter a filename (will get over-written if it already exists.")]
    [string]$target_file = "$home\Downloads\make_big_file.txt",
    [parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage="Enter the number of iterations (integer; larger number = larger file).")]
    [int][ValidateRange(1,10000)]$repetitions = 2
)

$lorem_ipsum = "
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse vitae ante dui. In dapibus feugiat leo, nec luctus tellus. Integer fermentum enim mattis nibh mattis, facilisis elementum arcu condimentum. Duis accumsan risus eget malesuada ornare. Aenean rutrum elementum velit sed viverra. Curabitur in tellus in diam volutpat pellentesque. Sed pretium ipsum accumsan ipsum iaculis porttitor. Proin sapien purus, commodo ac faucibus sed, tempus ac arcu. Quisque orci nibh, ultricies a ullamcorper et, facilisis eu ligula. Maecenas hendrerit quis sem id malesuada. Sed imperdiet ultricies orci, ornare pretium quam eleifend aliquam. Vestibulum et facilisis turpis. Maecenas nec lacus quis tortor imperdiet elementum. Ut ut augue commodo, suscipit felis non, placerat dui.

Pellentesque nec vehicula ligula. Sed bibendum aliquam ante, eu tincidunt velit tempus at. Nulla viverra, libero in venenatis venenatis, lorem purus gravida felis, vel semper lectus quam sit amet mauris. Sed eu blandit nibh. Nam vestibulum consectetur enim, vel faucibus mauris mattis ac. Sed maximus fringilla urna, sed dignissim felis sagittis et. Sed id aliquam metus.

Maecenas ut volutpat quam. Proin efficitur ac ipsum vitae rutrum. Etiam nec justo blandit, efficitur enim eu, efficitur metus. Nulla tellus eros, vestibulum nec orci vel, ultrices bibendum nunc. Cras et metus a nibh maximus dapibus. Nullam molestie risus sit amet neque commodo pellentesque. Aliquam elit orci, pretium ut odio nec, laoreet lacinia ante. Fusce lectus metus, scelerisque a luctus ac, sodales venenatis justo. Curabitur sit amet egestas mauris. Sed a mi tempor, malesuada diam viverra, eleifend erat. Duis eros elit, finibus sed dolor sed, aliquam rhoncus tellus. Proin magna justo, interdum eu laoreet interdum, elementum eget arcu. Maecenas imperdiet a est vitae tincidunt. Nulla facilisi. Morbi nibh magna, semper sed elementum vel, placerat eget neque.

Etiam tempus vitae metus nec interdum. Cras id neque ligula. Morbi dignissim tortor vitae nunc viverra pretium. Suspendisse elementum sem eu justo pellentesque, non tristique odio ultrices. Nam aliquet metus quis sapien congue sollicitudin. Duis eget fringilla lorem. Nam et diam risus. Donec maximus turpis euismod mauris efficitur posuere. Fusce mauris urna, fringilla eget nunc vitae, efficitur euismod odio. Aenean eleifend pellentesque arcu, non semper sem sagittis eu. Aenean egestas ultrices nulla et rhoncus. Donec dictum semper ullamcorper. Donec vitae metus odio. Aliquam erat volutpat. Vivamus lacinia purus nec odio tincidunt, sit amet feugiat nibh varius. Interdum et malesuada fames ac ante ipsum primis in faucibus.

Donec fringilla libero sed tellus rutrum, quis suscipit dolor gravida. Proin eu congue nibh, in blandit dui. Maecenas quis ante ultricies, ullamcorper urna eu, tempor neque. Nunc eu molestie nulla. Pellentesque eleifend urna erat, vel pharetra ligula tristique a. Etiam porta sed arcu ac vestibulum. Phasellus pretium nec est ullamcorper volutpat. Etiam eleifend sem nec lobortis maximus. Ut rhoncus metus efficitur, euismod tellus venenatis, faucibus libero. Nunc urna risus, ultrices ut augue venenatis, tincidunt ultrices felis. Sed vulputate consequat nisl. Vivamus euismod mauris vel consequat bibendum. Donec in elit eu nisi ullamcorper lacinia. Pellentesque bibendum varius eros a maximus. Mauris in libero posuere, congue urna id, tempor eros. Pellentesque tempus libero risus, ut iaculis quam egestas eget.
"
[int]$counter = 1
New-Item -Path $target_file -ItemType File -Force | Out-Null
while ($counter -le $repetitions) {
    # "Counter: $counter" | Add-Content -Path $target_file -Force
    $lorem_ipsum | Add-Content -Path $target_file -Force
    $counter += 1
}
"`nSee $target_file."