// @annotation:tour baby_steps
// 
// <-- click the blue icon in the gutter of line 1 for instructions on this lesson
// 
// For a detailed explanation of this tutorial, refer to the README.md file 
// then starting coding in this file

var result = 0

for (var i = 2; i < process.argv.length; i++)
  result += Number(process.argv[i])

console.log(result)