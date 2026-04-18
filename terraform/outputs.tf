output "api_url" {
  description = "Aapka naya URL Shortener API link ye hai:"
  value       = aws_apigatewayv2_api.http_api.api_endpoint
}

