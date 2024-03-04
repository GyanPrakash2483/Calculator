function expression(expression) {
    expression = expression.replaceAll('%', '/100*');
    expression = expression.replaceAll('π', 'Math.PI');
    expression = expression.replaceAll('×', '*');
    expression = expression.replaceAll('√', 'Math.sqrt');
    expression = expression.replaceAll('²', '**2');

    console.log(expression);

    return eval(expression);
}

module.exports = {
    expression,
}