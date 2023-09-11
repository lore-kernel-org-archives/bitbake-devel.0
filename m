Return-Path: <develop@schnelte.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA2DEE57DF
	for <webhook@archiver.kernel.org>; Mon, 11 Sep 2023 14:14:02 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by mx.groups.io with SMTP id smtpd.web10.59462.1694441634116167830
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Sep 2023 07:13:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: schnelte.de, ip: 212.227.126.134, mailfrom: develop@schnelte.de)
Received: from [192.168.178.56] ([91.33.147.138]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MwQCb-1pnk8r0fTR-00sQ1u for <bitbake-devel@lists.openembedded.org>; Mon, 11
 Sep 2023 16:13:52 +0200
Message-ID: <29acfeb3-246f-4ddf-8701-a5ee6d7affaf@schnelte.de>
Date: Mon, 11 Sep 2023 16:13:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: bitbake-devel@lists.openembedded.org
From: Matthias Schnelte <develop@schnelte.de>
Subject: [PATCH] Adds vscode devcontainer support
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RFZI3I+ttNzWbnJAeMFwpIpfi37mHH7bCsTtIaUAxafjBC8TwIs
 Z4KumNBaXTdsLSHIS8iI/5aygo5uPaGH+cCkfEecSEHNkGfD3qGHlLQLcSbgIPUGkMu9+Ie
 ltynd6TBW6U8l4GUNH2TnuzKIpLKst7JFB+182MN2K8KJUNFmEoskYjdVfW/tFJJcIO0Nza
 R1S4ugaN4TJi6WMCvNNSA==
UI-OutboundReport: notjunk:1;M01:P0:Zy0WAqG5rAc=;0LlScvMU1JhT16WLDMPVEoPI5/6
 K4ArdN1bpE0We5W+xZKMV5dUh4R2bkHJgkdOCNK/+xMHoEbRmutxIO6kU7Qtti1ZsUyC7Yb9P
 3Y4YYfgD8KeimV1pdbKuK6rPmsTmBNTGZGa1FPfuTHPnKcx6ulS0fsErnXtxKp8sX4T1qXd5Y
 Gh8s3Z05tR8NbiJVjmjg7YvxsYeBea1JLEYMy19cdvEp0/9SyNEPPsmQ6lH91drh4q10eCHxc
 mCqJ+xU2J7RJpNn8+jauurML+uuU15om2QZtklSlWByxfB2XHPyAGW4P/RqFqHictLCgPGxRz
 /AQ7QbPEVW+bPfpGXEk+/3589Kcx0JrxSS67A0zC8tLS44lq+Y4NV9LcCRuOVUZvJptc7z53k
 ggwoZMDXq74ed3Pk8m2Bn6LMzGMadOXGaRyrVHyBHKZYFId3W0jcuZv7H709SmTkXdQUoAklO
 9Wse8Wce9/85lC48NczgrmUnc9ViY6JLvGdlOFdKMdS/7IpsWCL5d7fV5Fv3+O3fVQ4YW41DQ
 kapDRu7HqVPNO4hH6pRyWiaXcmk9iODAycICfpErKSLQvFEL9v5EFDrUcIkUXdyYs8PeSSh/i
 ba7nsKBRHj8BqzubuBGiNCaqJq23v3tUM6TvoMRawDSBFlVvhXAE4JL4k3XRDLFHAeF/cM/lX
 ZhixVkflXtusrAr49GUZKDnonDn8WM1M/Kezh1B+G8T5EXbR4kkkbpNo+AyNJ6FnCtQrE2Tyo
 guapkiTQFnY4IqJ573MuhFoJWUGeIUALY1scN5aTaL6nDhjDLnNdoLmX+YCS0LWq7QLgmh5iG
 DjWYawPD3R8deYgF/SLaVY1MJypxrxb+UEjMSd9rgWzv+m3Oqp+FC+A5y+oyiYg4e9XrsQrPW
 FaRwu27CDYiNejQ==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Sep 2023 14:14:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15032

Visual studio code is injecting a git credential helper
into every dev container. This helper is forwarding the git credentials
from the host into the container.

In order for this helper to work the REMOTE_CONTAINERS_IPC
needs to be available in the environment for all git operations
that require authentication.
---
  lib/bb/fetch2/__init__.py | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 765aedd5..552a0939 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -874,7 +874,8 @@ FETCH_EXPORT_VARS = ['HOME', 'PATH',
                       'AWS_SECRET_ACCESS_KEY',
                       'AWS_DEFAULT_REGION',
                       'GIT_CACHE_PATH',
-                     'SSL_CERT_DIR']
+                     'SSL_CERT_DIR',
+                     'REMOTE_CONTAINERS_IPC']

  def get_fetcher_environment(d):
      newenv = {}
-- 
2.34.1


