Return-Path: <jsbronder@cold-front.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D30CC433EF
	for <webhook@archiver.kernel.org>; Mon, 18 Oct 2021 19:01:55 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 by mx.groups.io with SMTP id smtpd.web10.11.1634583714509355985
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Oct 2021 12:01:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cold-front.org header.s=mesmtp header.b=UZnJRzbk;
 spf=pass (domain: cold-front.org, ip: 66.111.4.29,
 mailfrom: jsbronder@cold-front.org)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id CABA15C0118;
	Mon, 18 Oct 2021 15:01:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 18 Oct 2021 15:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cold-front.org;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=mesmtp; bh=pCKE55coOv
	X+1JnmK2mOaAa2Ccx10QQoQabccv3T2zM=; b=UZnJRzbka1sNMJUyEeDCaRzrUU
	Ayr4ITBQ8tNbD/iWZPLhBLHFiEiObmKFbE+xuitbENhyky3QywxLJF7t8Dgw/WtR
	bfD6it5dBX/i9Robuge5NAZ0UiwN3VgzM1JY91D1YE8uTcZez/TkQBRSDN9dr0Aj
	YsGeucuO1T/HB/3oU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:date:from
	:in-reply-to:message-id:mime-version:references:subject:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; bh=pCKE55coOvX+1JnmK2mOaAa2Ccx10QQoQabccv3T2zM=; b=eduARenw
	RRjQ6ZtjjCjqTVHi24jY7sL0Gqy7j0b0wiDQthrTAbYgBT8WIp5A09feQTqxHdrV
	FDM1BruR+m52PuHNxleUkEhzTPFK4nMQGDwDebchA1fqRHFXAM/7BGjuKUBntNwv
	eHW3TU0r2eijGHXeX/+f+bVGxpDufOwd8j/7zjGJHnwChytdZbJOl+I7jHMmTPQE
	zioR7631aX5pG4iTZeQ/1t0YNXWzDttAZ6xfz0shF+CGM8uW4JW4fq+47eS9GxKs
	yE5kvdmjDrR6o7HeSRybK3bYW8sKUYlAZUkE+a+CQVmO9NSDHwSkB2O2Dak5yanN
	DdYqAxXuKjnCVw==
X-ME-Sender: <xms:ocRtYbXubRj63jWQciu9liBcilNI45rQzFrJtFFguKuq1ZZka8fkPw>
    <xme:ocRtYTldF3iOlU0XJufPbjks52cRDz7rVpAcfg5LCcSBm8rS-m7ExVApfFIW8xfBp
    MbiI2VWkd1Zt3ZrPA>
X-ME-Received: 
 <xmr:ocRtYXY_oHVup8AQDULwDNGm1P57wwPPW15qtIFUgDHrHJpQ6rRUnmOvh5SYqaxOUf8N6230vWnmOP5k0a79ZLapUSX6FeEF4EghHgSQRjtS>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvtddrvddvtddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhushht
    ihhnuceurhhonhguvghruceojhhssghrohhnuggvrhestgholhguqdhfrhhonhhtrdhorh
    hgqeenucggtffrrghtthgvrhhnpeetteehvedvhefglefftdekveeiledtueduffejjeef
    hfdugedtfeejtdegheevffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjshgsrhhonhguvghrsegtohhlugdqfhhrohhnthdrohhrgh
X-ME-Proxy: <xmx:ocRtYWV16idNhkU0r05N9f68tzcgSN7LVlQ63ILi-iGlKekYMAZHsQ>
    <xmx:ocRtYVl-rK-Egp3BsgZ-8-3VWPPSo4EjzOzDYsUid1sFCy6_C85Otg>
    <xmx:ocRtYTde6O6T3Q2Rybbr68V8NVjBo-zt6-DMimkv_Ph15cxR855t9A>
    <xmx:ocRtYbizE8uIvsU82x92U3oGHs9eIoPOQuVS8osetbHm0yuxIBQVHQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Oct 2021 15:01:53 -0400 (EDT)
From: Justin Bronder <jsbronder@cold-front.org>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>,
	Alexander Kanavin <alex@linutronix.de>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Justin Bronder <jsbronder@cold-front.org>
Subject: [1.46][PATCH 2/8] bitbake: correct the collections vs collections.abc
 deprecation
Date: Mon, 18 Oct 2021 15:01:35 -0400
Message-Id: <20211018190141.15806-3-jsbronder@cold-front.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018190141.15806-1-jsbronder@cold-front.org>
References: <20211018190141.15806-1-jsbronder@cold-front.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Oct 2021 19:01:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12795

From: Alexander Kanavin <alex.kanavin@gmail.com>

This becomes a hard error in python 3.10.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
---
 lib/bb/data_smart.py   | 2 +-
 lib/bb/persist_data.py | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 68770832..c8d2a437 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -17,7 +17,7 @@ BitBake build tools.
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
 import copy, re, sys, traceback
-from collections import MutableMapping
+from collections.abc import MutableMapping
 import logging
 import hashlib
 import bb, bb.codeparser
diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
index 5f4fbe35..56c983f8 100644
--- a/lib/bb/persist_data.py
+++ b/lib/bb/persist_data.py
@@ -12,6 +12,7 @@ currently, providing a key/value store accessed by 'domain'.
 #
 
 import collections
+import collections.abc
 import contextlib
 import functools
 import logging
@@ -19,7 +20,7 @@ import os.path
 import sqlite3
 import sys
 import warnings
-from collections import Mapping
+from collections.abc import Mapping
 
 sqlversion = sqlite3.sqlite_version_info
 if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
@@ -29,7 +30,7 @@ if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
 logger = logging.getLogger("BitBake.PersistData")
 
 @functools.total_ordering
-class SQLTable(collections.MutableMapping):
+class SQLTable(collections.abc.MutableMapping):
     class _Decorators(object):
         @staticmethod
         def retry(*, reconnect=True):
-- 
2.33.0


