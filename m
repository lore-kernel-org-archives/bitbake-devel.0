Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
	[209.85.221.43])
	by mail.openembedded.org (Postfix) with ESMTP id C50306C466
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Jan 2019 15:55:40 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id c14so971084wrr.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 07 Jan 2019 07:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=xHt6XdJUA+aMEG2v2Xi8QOtKtLiobuGFgPZ70zSogSQ=;
	b=darvW6u1HwSc9vUm5rIoD7/pn1ukSuu5gECrlW6nUWu+v0A73b1koFY+bJZiMSNmzX
	CfjSkaiq++CtoXm67L2TRlpNTtIV92RYl2enmDSo7TPN1hT+erL0S7MeJ46Zzzb7E3gH
	Vxwfs2wR+0fdjmjEovS6bSbsTRzSoJH1xekPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=xHt6XdJUA+aMEG2v2Xi8QOtKtLiobuGFgPZ70zSogSQ=;
	b=C99b0+agh/vYcYupUYzE6qaDe/OUM7Tq2cYtL7uPrPnZe4iyX1T0Uw5JnMrq+PEcHE
	sO+zJFkjOOIIaiWMfbPUSH5GRnnnKk3vt+IGtQVAAKjPONYHFkm98NbMsRO89CfNDkvJ
	14sXmyq7bQ8uKczmnzCIJRE3gAhjCUPUI2mdRMXWvmVz5/gPsem08MGZA0sIPHJJaMXr
	wVosvjbSG8+5HRM7D4shymeNWhRWi/UjpcZiCgeElEx6qETM8DwGCdImWqH0kRIQziqb
	WweTg1mzaHDzF4advJ+TfSLefsZZj1iVylLYrRh0xqhZ2ILjcpMlHdkkkpPa/CIYGnuF
	HOyw==
X-Gm-Message-State: AJcUukfc6OMikUX14uEcJifm9YxRk2jezRHVwWtR5GFhKKe5aP56bF0h
	X6HrWfKdw5TqIUV2O3cwQkx8Kxwfo8W7Pg==
X-Google-Smtp-Source: ALg8bN6MnVCEp79lk6gNTWjyel3/9VRytyJk3WSQK6O4Zq+ECSpoBKEfcuhjapy88r4u12DI3phP+w==
X-Received: by 2002:a5d:46cd:: with SMTP id g13mr54132874wrs.49.1546876541195; 
	Mon, 07 Jan 2019 07:55:41 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	o9sm6400347wmh.3.2019.01.07.07.55.40
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 07 Jan 2019 07:55:40 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 Jan 2019 15:55:36 +0000
Message-Id: <20190107155536.6062-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190107155536.6062-1-richard.purdie@linuxfoundation.org>
References: <20190107155536.6062-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 4/4] cooker: Split recipes to parse amongst threads ahead of time
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
X-List-Received-Date: Mon, 07 Jan 2019 15:55:41 -0000
Content-Transfer-Encoding: 8bit

We have two choices, split the recipes amongst the parsing threads in
blocks ahead of time, or have a queue which parsers pull from when idle.

The optimum approach depends on how similar the pieces are. For the single
recipe reparse case, there is currently a significant wait for the feeder
thread to start (around 0.25s in a 2s command).

Its possible splitting into blocks in advance may be unluckly for some other
workloads but experimentally it seems to work better overall for me at least.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 9b2a0920f9..e6b8d880ae 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1941,8 +1941,8 @@ class Parser(multiprocessing.Process):
                 result = pending.pop()
             else:
                 try:
-                    job = self.jobs.get(timeout=0.25)
-                except queue.Empty:
+                    job = self.jobs.pop()
+                except IndexError:
                     break
                 result = self.parse(*job)
 
@@ -2029,12 +2029,12 @@ class CookerParser(object):
             self.parser_quit = multiprocessing.Queue(maxsize=self.num_processes)
             self.result_queue = multiprocessing.Queue()
 
-            self.jobs = multiprocessing.Queue()
-            for j in self.willparse:
-                self.jobs.put(j)
+            def chunkify(lst,n):
+                return [lst[i::n] for i in range(n)]
+            self.jobs = chunkify(self.willparse, self.num_processes)
 
             for i in range(0, self.num_processes):
-                parser = Parser(self.jobs, self.result_queue, self.parser_quit, init, self.cooker.configuration.profile)
+                parser = Parser(self.jobs[i], self.result_queue, self.parser_quit, init, self.cooker.configuration.profile)
                 parser.start()
                 self.process_names.append(parser.name)
                 self.processes.append(parser)
@@ -2062,8 +2062,6 @@ class CookerParser(object):
             for process in self.processes:
                 self.parser_quit.put(None)
 
-            self.jobs.cancel_join_thread()
-
         for process in self.processes:
             if force:
                 process.join(.1)
-- 
2.19.1


