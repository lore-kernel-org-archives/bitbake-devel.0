Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <caleb@signalessence.com>) id 1RyUel-00029M-55
	for bitbake-devel@lists.openembedded.org;
	Fri, 17 Feb 2012 21:43:51 +0100
Received: by iaby12 with SMTP id y12so5201178iab.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Feb 2012 12:35:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.50.222.132 with SMTP id qm4mr254477igc.21.1329510935778; Fri,
	17 Feb 2012 12:35:35 -0800 (PST)
Received: by 10.43.47.10 with HTTP; Fri, 17 Feb 2012 12:35:35 -0800 (PST)
Date: Fri, 17 Feb 2012 12:35:35 -0800
Message-ID: <CALy7FZHSxCmTD+cTAuRASaQNuw7mqGu44oYkVybsdgTJ-H6r1g@mail.gmail.com>
From: Caleb Crome <caleb@signalessence.com>
To: bitbake-devel@lists.openembedded.org
X-Gm-Message-State: ALoCoQnWJ9NEJyKLazmVIM8YcfY8P3ow5F5g5X8UpZ/dWBsGwD7U2UrJr81pt0sVbPajZq/KyhJe
Subject: bitbake Parser hangs on single core cpus
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 17 Feb 2012 20:43:51 -0000
Content-Type: multipart/alternative; boundary=14dae934093f0d562a04b92ee3e5

--14dae934093f0d562a04b92ee3e5
Content-Type: text/plain; charset=ISO-8859-1

From 30feca0ab3f5941c88ec28d503940e0c6c212c6a Mon Sep 17 00:00:00 2001


From: Caleb Crome <caleb@signalessence.com>


Date: Fri, 17 Feb 2012 12:21:59 -0800


Subject: [prefix=PATCH] There seems to be a bug in the number of Parser


 threads created.  The number of threads is


 self.num_processes - 1 due to the range(1,


 self.num_processes).





This causes the Parser to hang at 0% on single core machines.





This fixes the Parsers to work on singlecore machines.


---
 lib/bb/cooker.py |    2 +-


 1 files changed, 1 insertions(+), 1 deletions(-)





diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py


index 8188aae..1a9cab7 100644


--- a/lib/bb/cooker.py


+++ b/lib/bb/cooker.py


@@ -1534,7 +1534,7 @@ class CookerParser(object):
             self.result_queue = multiprocessing.Queue()


             self.feeder = Feeder(self.willparse, self.jobs,
self.feeder_quit)

             self.feeder.start()


-            for i in range(1, self.num_processes):


+            for i in range(0, self.num_processes):


                 parser = Parser(self.jobs, self.result_queue,
self.parser_quit, init)

                 parser.start()


                 self.processes.append(parser)


--


1.7.5.4

--14dae934093f0d562a04b92ee3e5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: base64

PGRpdj5Gcm9tIDMwZmVjYTBhYjNmNTk0MWM4OGVjMjhkNTAzOTQwZTBjNmMyMTJjNmEgTW9uIFNl
cCAxNyAwMDowMDowMCAyMDAxIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKCgPC9kaXY+PGRpdj5Gcm9tOiBDYWxlYiBDcm9tZSAm
bHQ7PGEgaHJlZj0ibWFpbHRvOmNhbGViQHNpZ25hbGVzc2VuY2UuY29tIj5jYWxlYkBzaWduYWxl
c3NlbmNlLmNvbTwvYT4mZ3Q7IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgPC9k
aXY+CjxkaXY+RGF0ZTogRnJpLCAxNyBGZWIgMjAxMiAxMjoyMTo1OSAtMDgwMCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoDwvZGl2PjxkaXY+U3ViamVjdDogW3ByZWZp
eD1QQVRDSF0gVGhlcmUgc2VlbXMgdG8gYmUgYSBidWcgaW4gdGhlIG51bWJlciBvZiBQYXJzZXIg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoDwvZGl2Pgo8ZGl2PqB0aHJlYWRzIGNyZWF0ZWQuIKBUaGUgbnVtYmVyIG9mIHRocmVh
ZHMgaXMgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKA8L2Rpdj48ZGl2PqBzZWxm
Lm51bV9wcm9jZXNzZXMgLSAxIGR1ZSB0byB0aGUgcmFuZ2UoMSwgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKA8L2Rpdj4KPGRpdj6gc2VsZi5udW1fcHJvY2Vzc2VzKS4goCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgPC9kaXY+
PGRpdj6gIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgPC9kaXY+CjxkaXY+VGhpcyBjYXVzZXMgdGhlIFBh
cnNlciB0byBoYW5nIGF0IDAlIG9uIHNpbmdsZSBjb3JlIG1hY2hpbmVzLiCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoDwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoDwvZGl2Pgo8ZGl2PlRoaXMgZml4
ZXMgdGhlIFBhcnNlcnMgdG8gd29yayBvbiBzaW5nbGVjb3JlIG1hY2hpbmVzLiCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoKA8L2Rpdj48ZGl2Pi0tLTwvZGl2PjxkaXY+CqBsaWIvYmIvY29va2VyLnB5
IHwgoCCgMiArLSCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKA8L2Rpdj48ZGl2PqAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbnMoLSkgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKA8L2Rpdj4KPGRpdj6gIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgPC9kaXY+PGRpdj5kaWZmIC0tZ2l0IGEvbGliL2JiL2Nvb2tlci5weSBi
L2xpYi9iYi9jb29rZXIucHkgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKCgPC9kaXY+Cjxk
aXY+aW5kZXggODE4OGFhZS4uMWE5Y2FiNyAxMDA2NDQgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoDwvZGl2PjxkaXY+LS0tIGEvbGliL2JiL2Nvb2tlci5w
eSCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
oDwvZGl2Pgo8ZGl2PisrKyBiL2xpYi9iYi9jb29rZXIucHkgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoKA8L2Rpdj48ZGl2PkBAIC0xNTM0LDcg
KzE1MzQsNyBAQCBjbGFzcyBDb29rZXJQYXJzZXIob2JqZWN0KTo8L2Rpdj4KPGRpdj6gIKAgoCCg
IKAgoCCgc2VsZi5yZXN1bHRfcXVldWUgPSBtdWx0aXByb2Nlc3NpbmcuUXVldWUoKSCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKCgPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgc2VsZi5mZWVkZXIgPSBGZWVk
ZXIoc2VsZi53aWxscGFyc2UsIDxhIGhyZWY9Imh0dHA6Ly9zZWxmLmpvYnMiPnNlbGYuam9iczwv
YT4sIHNlbGYuZmVlZGVyX3F1aXQpIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgoDwvZGl2Pgo8ZGl2PqAgoCCgIKAgoCCgIKBzZWxmLmZlZWRl
ci5zdGFydCgpIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoKA8
L2Rpdj48ZGl2Pi0goCCgIKAgoCCgIKBmb3IgaSBpbiByYW5nZSgxLCBzZWxmLm51bV9wcm9jZXNz
ZXMpOiCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKA8L2Rpdj4KPGRpdj4rIKAgoCCgIKAgoCCg
Zm9yIGkgaW4gcmFuZ2UoMCwgc2VsZi5udW1fcHJvY2Vzc2VzKTogoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKAgoHBhcnNlciA9IFBhcnNlcig8YSBo
cmVmPSJodHRwOi8vc2VsZi5qb2JzIj5zZWxmLmpvYnM8L2E+LCBzZWxmLnJlc3VsdF9xdWV1ZSwg
c2VsZi5wYXJzZXJfcXVpdCwgaW5pdCkgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgoDwvZGl2Pgo8ZGl2PqAgoCCgIKAgoCCgIKAgoCCgcGFyc2VyLnN0YXJ0
KCkgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKA8L2Rpdj48
ZGl2PqAgoCCgIKAgoCCgIKAgoCCgc2VsZi5wcm9jZXNzZXMuYXBwZW5kKHBhcnNlcikgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoKA8L2Rpdj4KPGRpdj4tLSCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKCgPC9kaXY+PGRpdj4xLjcuNS40IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgPC9kaXY+CjxkaXY+PGJyPjwvZGl2
PjxkaXY+PGJyPjwvZGl2Pgo=

--14dae934093f0d562a04b92ee3e5--
