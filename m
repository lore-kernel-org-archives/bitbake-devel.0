Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4B3C433EF
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 20:20:32 +0000 (UTC)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by mx.groups.io with SMTP id smtpd.web12.14214.1645302031091928703
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 12:20:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=n096PBrb;
 spf=fail (domain: huawei.com, ip: 66.111.4.224,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailnew.nyi.internal (Postfix) with ESMTP id 6E1EC580560;
	Sat, 19 Feb 2022 15:20:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 19 Feb 2022 15:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=56ZDIo
	RqZwNHsE23bKkq2A4EISjLxBhItCWsJCkWuwI=; b=n096PBrbsxqtGOLTEMCuvt
	dAMkx4lKmY+aRZJKS1+72/44qR+QX+4aEIarYxctGJ+stbQ3BgfZrmRQq9tWMXOt
	YzMzPTNdvwxeNGeW/xRz7CbSDZdh308iavEXebswcmTDJuVk73AzexPm/DXVOSum
	ZJ70DTUCaImKRN4bBzZFwN/p9o9A7Z54Kt8YyI5ncvk12a3G2NA/lbxEVFBRbn6X
	szyq9g1NMCN8D8bZ+XNMkp7F1yBCNUa+djDxumTf/tHDUKEF6ajvlqyTtU3AUqyP
	bneoU9GL0fCgvEDjxwjLEI4LrX2QLGaWe6TYCcTC8u/arjeqGMrPVBMyuKtgXKCw
	==
X-ME-Sender: <xms:DlERYoEh-NrnbXNMvWXq6z-UFLjhaPSwoWM1BTjV8QvWBIRROup-2A>
    <xme:DlERYhVGojKesb0FcanQaQtgibL6_T9-lJDzJcn6SvPEuc77I96BZM9hxg8DjNad3
    Qt8pJPFBPSPUYSJHA>
X-ME-Received: 
 <xmr:DlERYiINyyILXCkDjg9I2ml-YQCH2r8bBWp1IDzAtNYtM0xHOwJe7t_jgPVinpOI7hAKiE6x_nFnWniX5J_GQ99LT8v13ufv9K5H0YROFNcsqrosWitesilV-Nydqn4>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgddufeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepkgihghhmuhhnthcumfhrhihnihgtkhhiuceoiiihghhmuhhn
    thdrkhhrhihnihgtkhhisehhuhgrfigvihdrtghomheqnecuggftrfgrthhtvghrnhepgf
    ffgfejffefieeffeehtedvudfhkeeuteegieejvdehlefhhffhgfelheefueehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiiihghhmuhhnth
    drkhhrhihnihgtkhhisehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:DlERYqGPfBoVkuf6EOvqZPWJKJofmwil-SGuxlA2JkaH9vDglB6Qhg>
    <xmx:DlERYuWRw3JvdHeuN1mrPlnlJNzJWSTfWY9dfTv7zXnzQ3ee9pXHGg>
    <xmx:DlERYtN4WyhdiCHxAIDvu1_Gni2G1oAStpFAz1hr5HGE3nyRW3kCyg>
    <xmx:DlERYpBGP-yWyqckIF8SEqmE_a3jBah4MViQxOz72udo3If4Aqb7cQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 15:20:29 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCH 3/3] simplediff: Add type annotations
Date: Sat, 19 Feb 2022 21:19:57 +0100
Message-Id: <20220219201957.8329-3-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220219201957.8329-1-zygmunt.krynicki@huawei.com>
References: <20220219201957.8329-1-zygmunt.krynicki@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 20:20:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13391

I was trying to grok how various parts of bitbake work. As a habit I
make type annotations, as those help both me and, perhaps, others.

Introducing typing to an existing project is somewhat challenging, but
by now, well established. It's good to start from any leaf module and
work up from there.

I've picked, somewhat at random, the simplediff module, since it's
small, self-contained and might be used as a starting point for the
discussion around type hints.

With the patch applied, one can run mypy as follows:

        mypy --strict ./lib/simplediff

The module now has strict typing compatibility. Allowing it to be used
in a typed context.

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/simplediff/__init__.py | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/lib/simplediff/__init__.py b/lib/simplediff/__init__.py
index 64ec64b4..a1866ba1 100644
--- a/lib/simplediff/__init__.py
+++ b/lib/simplediff/__init__.py
@@ -13,8 +13,18 @@ May be used and distributed under the zlib/libpng license
 __all__ = ['diff', 'string_diff', 'html_diff']
 __version__ = '1.0'
 
-
-def diff(old, new):
+from typing import (
+    Callable,
+    Dict,
+    List,
+    Sequence,
+    Tuple,
+    TypeVar,
+)
+
+T = TypeVar('T', str, int)
+
+def diff(old: List[T], new: List[T]) -> List[Tuple[str, List[T]]]:
     '''
     Find the differences between two lists. Returns a list of pairs, where the
     first value is in ['+','-','='] and represents an insertion, deletion, or
@@ -53,7 +63,7 @@ def diff(old, new):
     '''
 
     # Create a map from old values to their indices
-    old_index_map = dict()
+    old_index_map: Dict[T, List[int]] = dict()
     for i, val in enumerate(old):
         old_index_map.setdefault(val,list()).append(i)
 
@@ -73,7 +83,7 @@ def diff(old, new):
     # seen so far (`sub_length`), we update the largest substring
     # to the overlapping strings.
 
-    overlap = dict()
+    overlap: Dict[int, int] = dict()
     # `sub_start_old` is the index of the beginning of the largest overlapping
     # substring in the old list. `sub_start_new` is the index of the beginning
     # of the same substring in the new list. `sub_length` is the length that
@@ -85,7 +95,7 @@ def diff(old, new):
     sub_length = 0
 
     for inew, val in enumerate(new):
-        _overlap = dict()
+        _overlap: Dict[int, int] = dict()
         for iold in old_index_map.get(val,list()):
             # now we are considering all values of iold such that
             # `old[iold] == new[inew]`.
@@ -110,7 +120,7 @@ def diff(old, new):
                        new[sub_start_new + sub_length : ])
 
 
-def string_diff(old, new):
+def string_diff(old: str, new: str) -> List[Tuple[str, List[str]]]:
     '''
     Returns the difference between the old and new strings when split on
     whitespace. Considers punctuation a part of the word
@@ -139,7 +149,7 @@ def string_diff(old, new):
     return diff(old.split(), new.split())
 
 
-def html_diff(old, new):
+def html_diff(old: str, new: str) -> str:
     '''
     Returns the difference between two strings (as in stringDiff) in
     HTML format. HTML code in the strings is NOT escaped, so you
@@ -160,13 +170,14 @@ def html_diff(old, new):
         >>> html_diff('The quick brown fox', 'The fast blue fox')
         'The <del>quick brown</del> <ins>fast blue</ins> fox'
     '''
-    con = {'=': (lambda x: x),
+    con: Dict[str, Callable[[str], str]] = {
+           '=': (lambda x: x),
            '+': (lambda x: "<ins>" + x + "</ins>"),
            '-': (lambda x: "<del>" + x + "</del>")}
     return " ".join([(con[a])(" ".join(b)) for a, b in string_diff(old, new)])
 
 
-def check_diff(old, new):
+def check_diff(old: Sequence[str], new: Sequence[str]) -> None:
     '''
     This tests that diffs returned by `diff` are valid. You probably won't
     want to use this function, but it's provided for documentation and
-- 
2.25.1


