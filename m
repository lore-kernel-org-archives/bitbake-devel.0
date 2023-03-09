Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1B9C61DA4
	for <webhook@archiver.kernel.org>; Thu,  9 Mar 2023 22:52:35 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web10.5525.1678402345940805964
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Mar 2023 14:52:26 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from lons-builder.int.hatle.net (76.164.132.203.bevcomm.net [76.164.132.203] (may be forged))
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 329MqNH6010422
	for <bitbake-devel@lists.openembedded.org>; Thu, 9 Mar 2023 16:52:23 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH 0/2] Add fetch2 wget exception handler
Date: Thu,  9 Mar 2023 16:52:19 -0600
Message-Id: <20230309225221.273750-1-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Mar 2023 22:52:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14534

While rare we were getting TimeoutError exceptions in our CI infrastructure.
It is unclear what the cause is (still being investigated), but from what
I can tell, it appears connection opens, we do a number of invalid requests
and the remote side just drops further requests (not closing the connection)
which results in a socket TimeoutError.

Backtrace we receieved follows:

Checking sstate mirror object availability...ERROR: SState: cannot test file://13/8b/sstate:base-passwd:cortexa72-cortexa53-xilinx-linux:3.5.52:r0:cortexa72-cortexa53:10:138b29e1fe5981198dbca2fecdef5712826e63f2593e4d604ef54d6d5d51bd6d_package.tar.zst: TimeoutError('timed out')
Traceback (most recent call last):
  File "/poky/meta/classes-global/sstate.bbclass", line 1010, in checkstatus
    fetcher.checkstatus()
  File "/poky/bitbake/lib/bb/fetch2/__init__.py", line 1833, in checkstatus
    ret = m.try_mirrors(self, ud, self.d, mirrors, True)
  File "/poky/bitbake/lib/bb/fetch2/__init__.py", line 1606, in try_mirrors
    return bool(try_mirrors(fetch, d, urldata, mirrors, check))
  File "/poky/bitbake/lib/bb/fetch2/__init__.py", line 1134, in try_mirrors
    ret = try_mirror_url(fetch, origud, uds[index], ld, check)
  File "/poky/bitbake/lib/bb/fetch2/__init__.py", line 1027, in try_mirror_url
    found = ud.method.checkstatus(fetch, ud, ld)
  File "/poky/bitbake/lib/bb/fetch2/wget.py", line 369, in checkstatus
    with opener.open(r, timeout=30) as response:
  File "/buildtools/sysroots/x86_64-petalinux-linux/usr/lib/python3.10/urllib/request.py", line 519, in open
    response = self._open(req, data)
  File "/buildtools/sysroots/x86_64-petalinux-linux/usr/lib/python3.10/urllib/request.py", line 536, in _open
    result = self._call_chain(self.handle_open, protocol, protocol +
  File "/buildtools/sysroots/x86_64-petalinux-linux/usr/lib/python3.10/urllib/request.py", line 496, in _call_chain
    result = func(*args)
  File "/poky/bitbake/lib/bb/fetch2/wget.py", line 174, in http_open
    return self.do_open(HTTPConnectionCache, req)
  File "/poky/bitbake/lib/bb/fetch2/wget.py", line 244, in do_open
    r = h.getresponse()
  File "/buildtools/sysroots/x86_64-petalinux-linux/usr/lib/python3.10/http/client.py", line 1374, in getresponse
    response.begin()
  File "/buildtools/sysroots/x86_64-petalinux-linux/usr/lib/python3.10/http/client.py", line 318, in begin
    version, status, reason = self._read_status()
  File "/buildtools/sysroots/x86_64-petalinux-linux/usr/lib/python3.10/http/client.py", line 279, in _read_status
    line = str(self.fp.readline(_MAXLINE + 1), "iso-8859-1")
  File "/buildtools/sysroots/x86_64-petalinux-linux/usr/lib/python3.10/socket.py", line 705, in readinto
    return self._sock.recv_into(b)
TimeoutError: timed out


Mark Hatle (2):
  wget.py: Add catch TimeoutError exception
  wget.py: Combine urlopener exceptions

 bitbake/lib/bb/fetch2/wget.py | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

-- 
2.25.1


