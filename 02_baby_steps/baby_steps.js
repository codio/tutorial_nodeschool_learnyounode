// @annotation:tour baby_steps
// 
// <-- click the blue icon in the gutter 
//     for instructions on this lesson
// 
// The README.md file contains complete instructions
// for using these tutorials.
// Then just start coding away in this file

var result = 0

for (var i = 2; i < process.argv.length; i++)
  result += Number(process.argv[i])

console.log(result)
