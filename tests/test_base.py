from unittest import TestCase


def setUpModule():
    pass


def tearDownModule():
    pass


class BaseTest(TestCase):

    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_base(self):
        print('Hello world')
