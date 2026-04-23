Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD74F589D4
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 13:30:45 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19711.1776951037161392921
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Apr 2026 06:30:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZGGHOJkC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d7badbd7dso3303819f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 23 Apr 2026 06:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1776951035; x=1777555835; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zJDyyp+gAfk03ptP5ty8xMcAmUb87JJu4m04GOEEkMU=;
        b=ZGGHOJkCo7ndPHSMJhWvd9MmJMG+Y921Vyrg1EZLBpQyN/FtJ1y80Q+0QYxlGLPTqb
         Ij4mw+zoWc/+fSaEATgn3K6tsW0KknDQmMXEfBV/GM913+uSHmXYCLam9PtVnwrYZSou
         9WgCsoGJsn9zyS49TjLEzpsKsK6Y0Adl5kwLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776951035; x=1777555835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJDyyp+gAfk03ptP5ty8xMcAmUb87JJu4m04GOEEkMU=;
        b=F0IbYKgjZYyG9yWBtw4p6zJTHWzfyIfYxLTdKRu4bFyvMX0Qe50F91c/TYcWQq66Im
         taxQWh/PsTQySbjImTgu+dfu17MCnAjFX2MoBFB1weWafC3IWWq1ih2Swl9DPO8/5P+6
         +jyulkgqNfN593d5HoZSJ0Xk9VSuBJKwA17HjEqDBR4Vvzs/2QnUN41L3h+l/hJVsbfk
         CzL0G8yAmsV5gzTCIsJFvwmQNWDqc5DkfR1grdcCkPEoRAWtM/U3xto14Ghkaui3uhY6
         PNfxxiJxxV70sMNFOfZ0LwgFr28a24ooEKeH1JKXHyiT9aeyXB0uDrVBTYTkm1z0B3/1
         WoZg==
X-Gm-Message-State: AOJu0Yz4N/jTiCX2vLYvC4FvlurR9WacN9XTU+WlRVCg9i/6aZboFEBd
	STQpbJwJp4xywtvEE9K0yRpxfpDfC9+qja66G1kSVLezabv0UMjQH3UyubKGKVC9v9lK6BKNDQw
	s5ZfkS9I=
X-Gm-Gg: AeBDievnQcn0fFQyybBax3NZp25L887xQ3yV7hceFUOho0pgse+XJ/DrczvkmtmcVou
	PCEWj8yg1q2vW09iS1PR7qUtSDpyuKtxyMHI/GARc4VxBuIf2+md5nl3NGV6JgbwNpM32BuNBuX
	KKkN2n/wpl4fYgTv7V2DdEZg7QuFlJInBxukZ1ttthbed9MfOWPkdS/0NmU7IkWnI8cg5Z2klRX
	A3t7/1JM3+DL94IYPXP00eaKXEzu0EuRfTbTywhXj/WChuFjsZclhMFNtsf5at9spHg3EaRKWLI
	6W+y7F2ExI0E/CZiki/9Qhl9EkmptmU3fYINSFBD1Tebe+s/EUoSo5ShP40GGNcfJyncHemAfmu
	gbhSBsZP3GqsSLjRlP4Q1bxXxKiqnUkqtSDUGxfEixmTI/JylJLE8WgTD+gc6yZ4cDmz3fIQJ8Q
	yMWDGIcHjyRzg4fbvkc7hqxAP6cOjtVQGldX+x2MC4QTPkidHISrvAqA1YC+PXgi6cBHTcExKWx
	Q==
X-Received: by 2002:a05:6000:24c8:b0:43c:ffb1:2214 with SMTP id ffacd0b85a97d-43fe3dc60dfmr42872790f8f.16.1776951034732;
        Thu, 23 Apr 2026 06:30:34 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8228:dac2:8992:4ae8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc09b1sm53762085f8f.9.2026.04.23.06.30.33
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 06:30:34 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] utils: Add filter_string function
Date: Thu, 23 Apr 2026 14:30:33 +0100
Message-ID: <20260423133033.1952809-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Apr 2026 13:30:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19381

There are cases where we would like the filter functionality but
don't want to read the data from a variable. Add a new function,
filter_string to allow this, basically separating filter() into
two functions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 7c5c5e8e65d..b04ff6ffc76 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1336,21 +1336,18 @@ def contains_any(variable, checkvalues, truevalue, falsevalue, d):
         return truevalue
     return falsevalue
 
-def filter(variable, checkvalues, d):
-    """Return all words in the variable that are present in the ``checkvalues``.
+def filter_string(val, checkvalues):
+    """Return all words in the string that are present in the ``checkvalues``.
 
     Arguments:
 
-    -  ``variable``: the variable name. This will be fetched and expanded (using
-       d.getVar(variable)) and then split into a set().
+    -  ``val``: the string data to filter after being split into a set().
     -  ``checkvalues``: if this is a string it is split on whitespace into a set(),
        otherwise coerced directly into a set().
     -  ``d``: the data store.
 
     Returns a list of string.
     """
-
-    val = d.getVar(variable)
     if not val:
         return ''
     val = set(val.split())
@@ -1360,6 +1357,22 @@ def filter(variable, checkvalues, d):
         checkvalues = set(checkvalues)
     return ' '.join(sorted(checkvalues & val))
 
+def filter(variable, checkvalues, d):
+    """Return all words in the variable that are present in the ``checkvalues``.
+
+    Arguments:
+
+    -  ``variable``: the variable name. This will be fetched and expanded (using
+       d.getVar(variable)) and then split into a set().
+    -  ``checkvalues``: if this is a string it is split on whitespace into a set(),
+       otherwise coerced directly into a set().
+    -  ``d``: the data store.
+
+    Returns a list of string.
+    """
+
+    val = d.getVar(variable)
+    return filter_string(val, checkvalues)
 
 def get_referenced_vars(start_expr, d):
     """

