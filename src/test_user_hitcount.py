import unittest
import hitcount

class HitCountTest(unittest.TestCase):

    def setUp(self):
        hitcount.r.delete("user1")

    def testOneHit(self):
        # increase the hit count for user1
        hitcount.hit("user1")
        # ensure that the hit count for user1 is just 1
        self.assertEqual(b'1', hitcount.getHit("user1"))


if __name__ == '__main__':
    unittest.main()