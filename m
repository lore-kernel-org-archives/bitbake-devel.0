Return-Path: <armccurdy@gmail.com>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id 478A7605B3
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Dec 2015 05:13:03 +0000 (UTC)
Received: by wmuu63 with SMTP id u63so157536664wmu.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Nov 2015 21:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=22fnPCRGCbpfaHfWYjI+H9gqDE9iwQzy1xZw8s9MOmM=;
	b=vWQG0s6QXerChai6/5V61inkLk0Nx75TK2jkmdBKhXrYn51lWrQ7GefUKz4uBs5yQ/
	hlqggic8AMt55YjQzrJTmIVdJ8pjqmdCdo5ZpFmB0YPokUsoA86QKH3mGfZUKlAY03Rt
	6MkPeE2SQr9QKSOfCBL4bzstp1xX5r9fhs/umleSqu4qkGCx8Yq8v4lC6njcxVtSJ2ee
	BvGKRKfjq12ywVH/gKTMmbx6x3CfLjJqORgYYaerFALc4FxLdNqb5ZzOjuHwwK+sj15Q
	c/7i+/2A5o/iGv42Lngufvw4lUsjLYmga9P4YnsBWrZywmJJQJlIm+N5bvlrzOaftJr7
	1yiA==
MIME-Version: 1.0
X-Received: by 10.194.200.134 with SMTP id js6mr89428115wjc.114.1448946784212; 
	Mon, 30 Nov 2015 21:13:04 -0800 (PST)
Received: by 10.194.140.38 with HTTP; Mon, 30 Nov 2015 21:13:04 -0800 (PST)
Date: Mon, 30 Nov 2015 21:13:04 -0800
Message-ID: <CAJ86T=U_qRVDbJZbCOT5XCwRP=Scs0g1+EYeg+HhjLZ-J7zwhw@mail.gmail.com>
From: Andre McCurdy <armccurdy@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: PREFERRED_VERSION with % wildcard picking unexpected version
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 01 Dec 2015 05:13:06 -0000
Content-Type: text/plain; charset=UTF-8

I have two recipes within a single layer:

  stblinux_3.14-1.7.bb
  stblinux_3.14-1.8.bb

If PREFERRED_VERSION_stblinux is set to "3.14%", then I would expect
the version 3.14-1.8 recipe to be selected, however 3.14-1.7 gets
selected instead.

Reversing the order of files stored in pkg_pn[pn] seems to help. Is it
a reasonable solution?


diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index 637e1fa..b7b1e46 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -234,6 +234,10 @@ def _filterProviders(providers, item, cfgData, dataCache):
     # than effectively random.
     providers.sort()

+    # Reverse the list to help ensure that multiple recipes with the same
+    # priority and preference are considered "highest version number first".
+    providers.reverse()
+
     # Collate providers by PN
     pkg_pn = {}
     for p in providers:

