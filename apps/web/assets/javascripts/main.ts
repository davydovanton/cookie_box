require("!style-loader!css-loader!sass-loader!../stylesheets/main.scss");

console.log('hello from webpack and ts');

document.querySelector('#repository-toggle').addEventListener('click', function() {
  document.querySelector('.repositories').classList.toggle('hide');
});
