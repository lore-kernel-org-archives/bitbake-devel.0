Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F034106ACF1
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 22:36:27 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3186.1773354983007366378
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Mar 2026 15:36:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BiHxtThb;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-663a60768f2so1495874a12.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Mar 2026 15:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773354981; x=1773959781; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NbVPGzQt2o9A6ZDDIrEYFs7tQlhOo3yyFogJ5pjnScs=;
        b=BiHxtThbDHbGruGeAsEPUREO+3O5jJu1r90KJcNn3nxyVS5+dJi7YaDWpfV12nt5/F
         fiVlvtTVgItAtGupL0IpSjNt/JutGWfeBkXeeFUqvgoOlW+odrcDzaM3EQ11Q0alxnVV
         xSNfAyXRt3OiD0RL6Iiobir2VNd9wM2HQyRrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773354981; x=1773959781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbVPGzQt2o9A6ZDDIrEYFs7tQlhOo3yyFogJ5pjnScs=;
        b=sIVG7TAMiS/svKaWTv1UIF8QgsFzC8bAjOGs+GDPVJL8tjSKPFUgQn+PRs6vDYAkVB
         QfD9RpfKSGrHq2qrwSJ3oagigHyR35Xstv7IQsEn1XRkxCm1/uLXxy8QzWm31aKpr9Gv
         HOKcgcO8eV/iC+aB55jQFMp3mVaYOqtrzeUyLU8lUavY/wtPTLQW3xPVYOnmwEBcdXj0
         PlN3IUX9cFLtnYcCiP9dtLvpr916lB//00XH8OAkQs9sz3fHL17tnDe/+rkbF9Vz2t+s
         fWz70jhfuUZxsXsJNplER1+gzwobVuL5hGUINNoZJ+IdSW/XLeILWfO8lSnVud/2NiOA
         G2nw==
X-Gm-Message-State: AOJu0Yz1Msq30Fv3WQOtM75xdfAw3Tu2p9qmEwO6T9rK5uEbe0dNyXH/
	WNOGZQyGsimlKpnFb0YFr3GBDyn5B9ZafqipGsQdxsM4YR/2pUCSJBlBKpd3zqONoOlGhyo2Ulo
	5tVgN3us=
X-Gm-Gg: ATEYQzyod2sqGCk1qpHNvB2AD3y7JseD3HnuHKTpu299uI56rnQKGEc3DRk+Q+ZtwVx
	G3bx0aL72lSp5D4/OUiqUTOPCW4WtqFl5ApIP1LON2OeUyY2nv0LNFtLhfyN6+mS6PkT1Lf9W5u
	i0aMZD/8UnjNxd0zExm1vUw6zLcJUHwkGWqyUfAAabbAmiVaTrcklYIxMggmHNwm/lp7A/ys7qa
	//cCvUSdR5VoAvEDEAEvZSdnddWeUpGTAZqMM0FnNUPY/YVX0biycwtfbZ1nL9wECY8ImTJLA7+
	nuHhUctyOhC3y/ioPmLbZit/Y4fsw1ObVDznQ+1NNEYH5gmijswcYCbI4n6iwNUecfSrWpT0Ukd
	eNIApIUSawfc2hFv7ydje9V/wNXkh2dWolyyguStBl3yTg1V9tEs8aq4Bv06fLi6d6Wr9i9fFUH
	/c+iNQolC1C+YtuFRTPs7vzk7i6kiBxFV5cs3faGh9ms9/P4nVxQ==
X-Received: by 2002:a05:6402:1e92:b0:663:b1f4:2636 with SMTP id 4fb4d7f45d1cf-663ba9bb62cmr617539a12.2.1773354980565;
        Thu, 12 Mar 2026 15:36:20 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:5251:8788:f414:2fc])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6634fdbc6c2sm871783a12.11.2026.03.12.15.36.19
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 15:36:19 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch/wget: Improve connection error handling
Date: Thu, 12 Mar 2026 22:36:18 +0000
Message-ID: <20260312223619.3735215-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Mar 2026 22:36:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19152

We see occasional connection errors in wget testing of sstate mirrors.

It appears there is a case where http.client.RemoteDisconnected is
returned against getrepsonse() which the current code doesn't handle
well.

Rather than trying to handle very specific error cases, catch any errors
and drop the cached connection in those cases in the do_open() code.

Similarly, try again, once in the case of errors in all cases rather
than trying to handle a specific exception list.

The traceback from the logs is included below for reference.

Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/a-full/build/layers/bitbake/lib/bb/fetch2/wget.py", line 415, in checkstatus
    with opener.open(r, timeout=100) as response:
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/urllib/request.py", line 519, in open
    response = self._open(req, data)
               ^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/urllib/request.py", line 536, in _open
    result = self._call_chain(self.handle_open, protocol, protocol +
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/urllib/request.py", line 496, in _call_chain
    result = func(*args)
             ^^^^^^^^^^^
  File "/srv/pokybuild/yocto-worker/a-full/build/layers/bitbake/lib/bb/fetch2/wget.py", line 178, in http_open
    return self.do_open(HTTPConnectionCache, req)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/srv/pokybuild/yocto-worker/a-full/build/layers/bitbake/lib/bb/fetch2/wget.py", line 249, in do_open
    r = h.getresponse()
        ^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/http/client.py", line 1374, in getresponse
    response.begin()
  File "/usr/lib/python3.11/http/client.py", line 318, in begin
    version, status, reason = self._read_status()
                              ^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/http/client.py", line 287, in _read_status
    raise RemoteDisconnected("Remote end closed connection without"
http.client.RemoteDisconnected: Remote end closed connection without response

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/a-full/build/layers/bitbake/lib/bb/fetch2/wget.py", line 228, in do_open
    h.request(req.get_method(), req.selector, req.data, headers)
  File "/usr/lib/python3.11/http/client.py", line 1282, in request
    self._send_request(method, url, body, headers, encode_chunked)
  File "/usr/lib/python3.11/http/client.py", line 1328, in _send_request
    self.endheaders(body, encode_chunked=encode_chunked)
  File "/usr/lib/python3.11/http/client.py", line 1277, in endheaders
    self._send_output(message_body, encode_chunked=encode_chunked)
  File "/usr/lib/python3.11/http/client.py", line 1037, in _send_output
    self.send(msg)
  File "/usr/lib/python3.11/http/client.py", line 998, in send
    self.sock.sendall(data)
OSError: [Errno 9] Bad file descriptor

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/a-full/build/layers/bitbake/lib/bb/fetch2/wget.py", line 415, in checkstatus
    with opener.open(r, timeout=100) as response:
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/urllib/request.py", line 519, in open
    response = self._open(req, data)
               ^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/urllib/request.py", line 536, in _open
    result = self._call_chain(self.handle_open, protocol, protocol +
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/urllib/request.py", line 496, in _call_chain
    result = func(*args)
             ^^^^^^^^^^^
  File "/srv/pokybuild/yocto-worker/a-full/build/layers/bitbake/lib/bb/fetch2/wget.py", line 178, in http_open
    return self.do_open(HTTPConnectionCache, req)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/srv/pokybuild/yocto-worker/a-full/build/layers/bitbake/lib/bb/fetch2/wget.py", line 246, in do_open
    raise urllib.error.URLError(err)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/wget.py | 41 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 4e3505599b4..a9d432b25d3 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -216,31 +216,20 @@ class Wget(FetchMethod):
 
                 try:
                     h.request(req.get_method(), req.selector, req.data, headers)
-                except socket.error as err: # XXX what error?
-                    # Don't close connection when cache is enabled.
-                    # Instead, try to detect connections that are no longer
-                    # usable (for example, closed unexpectedly) and remove
-                    # them from the cache.
-                    if fetch.connection_cache is None:
-                        h.close()
-                    elif isinstance(err, OSError) and err.errno == errno.EBADF:
-                        # This happens when the server closes the connection despite the Keep-Alive.
-                        # Apparently urllib then uses the file descriptor, expecting it to be
-                        # connected, when in reality the connection is already gone.
-                        # We let the request fail and expect it to be
-                        # tried once more ("try_again" in check_status()),
-                        # with the dead connection removed from the cache.
-                        # If it still fails, we give up, which can happen for bad
-                        # HTTP proxy settings.
+                    r = h.getresponse()
+                except:
+                    # This can happen when the server closes the connection despite the Keep-Alive.
+                    # Apparently urllib then uses the file descriptor, expecting it to be
+                    # connected, when in reality the connection is already gone.
+                    # We let the request fail and expect it to be
+                    # tried once more ("try_again" in check_status()),
+                    # with the dead connection removed from the cache.
+                    # If it still fails, we give up, which can happen for bad
+                    # HTTP proxy settings.
+                    if fetch.connection_cache:
                         fetch.connection_cache.remove_connection(h.host, h.port)
-                    raise urllib.error.URLError(err)
-                else:
-                    try:
-                        r = h.getresponse()
-                    except TimeoutError as e:
-                        if fetch.connection_cache:
-                            fetch.connection_cache.remove_connection(h.host, h.port)
-                        raise TimeoutError(e)
+                    h.close()
+                    raise
 
                 # Pick apart the HTTPResponse object to get the addinfourl
                 # object initialized properly.
@@ -404,9 +393,9 @@ class Wget(FetchMethod):
 
                 with opener.open(r, timeout=100) as response:
                     pass
-            except (urllib.error.URLError, ConnectionResetError, TimeoutError) as e:
+            except Exception as e:
                 if try_again:
-                    logger.debug2("checkstatus: trying again")
+                    logger.debug2("checkstatus: trying again after exception %s" % str(e))
                     return self.checkstatus(fetch, ud, d, False)
                 else:
                     # debug for now to avoid spamming the logs in e.g. remote sstate searches

