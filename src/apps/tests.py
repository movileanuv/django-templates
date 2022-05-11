from django.test import TestCase

from django.urls import reverse


class IndexViewTests(TestCase):
    def test_index_view_returns_200(self):
        url = reverse("index")
        response = self.client.get(url)
        self.assertEqual(response.status_code, 200)
