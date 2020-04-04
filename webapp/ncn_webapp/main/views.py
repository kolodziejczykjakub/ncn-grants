from django.shortcuts import render

# Create your views here.


def home(request):
    """Displays infographics.

    Args:
        request (HttpRequest): Object that contains metadata about the request.

    Returns:
        HttpResponse: An HTTP response class with a string as content.
    """
    return render(request, "main/home.html")
