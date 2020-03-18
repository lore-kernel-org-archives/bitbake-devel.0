Return-Path: <jacob.kroon@gmail.com>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id 24B8B60B3E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Mar 2020 23:17:58 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id h4so550285wru.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Mar 2020 16:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=uwsvGHxrFVAWULT92l0zNOg+isp4mPUpkeEYwmgr9TI=;
	b=q3gTYBp1v9nid033wN0L/OCsqdMpjv5sUJTSit1n+EHNUN3UZsCArzgbMh/W24fpp9
	ca80GHKI89W8+tjWPQNUjVx6TvH6hXRzt1I2MNk/vDl7sjpRNCkW0PAhCWUeOvU5E2rq
	JN5BJUnJym1JjQyz7FWFoVwlwJnzxJWBOmTpBQPFNPs2D8htVygLrBi7X7QjM76LdwM5
	ThhJQL0UJ6d+u30EmeEoxpMwl4Czsvaflxvm36qSUbhfP/VnqIdMqCn80I3qGOLo5tiz
	xZoW6WlfBM490VENv3dXP7JZAUzKxtAn0i2ew5xvF0Sq90GelrP/Thdzimy1FDPsGG9N
	Zp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=uwsvGHxrFVAWULT92l0zNOg+isp4mPUpkeEYwmgr9TI=;
	b=jT0c+itnhqARLVdCx2zem6RN+atKGQ9mvVdU9LL045PaLMWnxV4fTsrdcQa38HdvlK
	K6dpTMSiSjpJErCupvj3vvcvP4I/XzgqG0LxrTLfWY8W+27mGRnYb8EsqhKQBnGwGv1B
	EQ7HWyQTfLQLAidiOPi3sycHfRTVSor+DW8bR4d46RtqDf3XxfJu4JjvWrxlGaqlD0sp
	LgBbxzccHHQEmV+gwbYOmizySTrz4OLE5+gWfnk6RiglEfGKNlYe3Y3ZssJkVhm9OpAI
	E4hNnuqQrYR8WRKMYD00RB/yPUsuu15RLuR7hl2/7grKaI8A6HixoIuVPnJQCXK+TITo
	p6/g==
X-Gm-Message-State: ANhLgQ3qG1zcARdaMTJ6EpC2iJtWI7ygTuvMqtz4aTxPQMuzCZIq5V5y
	+M73ZhFC3H0XQXVEv22M8F9+LebY
X-Google-Smtp-Source: ADFU+vuc/Uh1ARTuqK7jWqWwFsbrFPjrdVjW3zeukKt8+m+sEyZ676uXxUXrNvNbvce8hQN9HS9kgg==
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr280028wru.127.1584573478603;
	Wed, 18 Mar 2020 16:17:58 -0700 (PDT)
Received: from localhost.localdomain (37-247-29-68.customers.ownit.se.
	[37.247.29.68])
	by smtp.gmail.com with ESMTPSA id l26sm393080wmi.37.2020.03.18.16.17.57
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 18 Mar 2020 16:17:57 -0700 (PDT)
From: Jacob Kroon <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 Mar 2020 00:17:37 +0100
Message-Id: <20200318231737.1169597-2-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318231737.1169597-1-jacob.kroon@gmail.com>
References: <20200318231737.1169597-1-jacob.kroon@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] bitbake-user-manual: immediate-variable-expansion: Correct description
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
X-List-Received-Date: Wed, 18 Mar 2020 23:17:58 -0000
Content-Transfer-Encoding: 8bit

References to undefined variables are preserved as is and do not
expand to nothing as in GNU Make.

Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
---
 .../bitbake-user-manual-metadata.xml              | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index bb5a7f86..10b58835 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -294,17 +294,20 @@
                 rather than when the variable is actually used:
                 <literallayout class='monospaced'>
      T = "123"
-     A := "${B} ${A} test ${T}"
+     A := "test ${T}"
      T = "456"
-     B = "${T} bval"
+     B := "${T} ${C}"
      C = "cval"
      C := "${C}append"
                 </literallayout>
                 In this example, <filename>A</filename> contains
-                "test 123" because <filename>${B}</filename> and
-                <filename>${A}</filename> at the time of parsing are undefined,
-                which leaves "test 123".
-                And, the variable <filename>C</filename>
+                "test 123", even though the final value of <filename>T</filename>
+                is "456".
+                The variable <filename>B</filename> will end up containing "456 cvalappend".
+                This is because references to undefined variables are preserved as is
+                during (immediate)expansion. This is in contrast to GNU Make, where undefined
+                variables expand to nothing.
+                The variable <filename>C</filename>
                 contains "cvalappend" since <filename>${C}</filename> immediately
                 expands to "cval".
             </para>
-- 
2.25.1


