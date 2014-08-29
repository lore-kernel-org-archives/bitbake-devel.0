Return-Path: <danismostlikely@gmail.com>
Received: from mail-qa0-f42.google.com (mail-qa0-f42.google.com
	[209.85.216.42])
	by mail.openembedded.org (Postfix) with ESMTP id 8035970281
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Aug 2014 19:46:18 +0000 (UTC)
Received: by mail-qa0-f42.google.com with SMTP id i13so2647234qae.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Aug 2014 12:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=noo76cHQkEXiYpBfasK6WWTolHGj6aA+wGyr5p95qHI=;
	b=arRunjgFpBU4v/BSXiI/EUCthoM6Fsecc2HQhVAE5KQ+9w1E4uhvaQq2GEo8pyt7Xi
	aJqIwk8n0f8Vae7Cyir8iJRE4J9mpauf7YZiwx6601u4bgNr6kZu6kfYNCUXqAtVTuEw
	aQJDlYN+DDVHC2iCOXOlUa/FjCOSBfx3Yx+2wPlG7q8FKgu2Hj3QtM9W/fjq4SVPsWF5
	IUmiLrpxKQeLv9b/vmsu+QQVnK8VqsAK+FgrkP4CjLejqor00Stt+avRoq7V/N8ZNavM
	jJyFmpxcXl1xYKKWqv6OdwyoT3h3r2r7Tvdief0IUhjgDT++JwLfnAKJdt/MDj3Q7d9H
	Oydg==
MIME-Version: 1.0
X-Received: by 10.224.61.144 with SMTP id t16mr21707399qah.2.1409341578074;
	Fri, 29 Aug 2014 12:46:18 -0700 (PDT)
Received: by 10.96.205.134 with HTTP; Fri, 29 Aug 2014 12:46:18 -0700 (PDT)
Date: Fri, 29 Aug 2014 13:46:18 -0600
Message-ID: <CACS+7ZSnwyCS0YnEd7X=3oHtVmhc3u80GbfMd85UfEYoznVz2Q@mail.gmail.com>
From: Dan McGregor <danismostlikely@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] knotty: ignore interrupted system calls
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
X-List-Received-Date: Fri, 29 Aug 2014 19:46:20 -0000
Content-Type: text/plain; charset=UTF-8

From: Dan McGregor <dan.mcgregor@usask.ca>

With the improved exception handling added in an earlier commit bitbake
now stops when recieving a SIGWINCH. This happens frequently when
disconnecting and reconnecting tmux sessions and bitbake didn't survive.
Restore old behaviour of ignoring interrupted system calls but keep
proper exception handling for other errors.

Signed-off-by: Dan McGregor <dan.mcgregor@usask.ca>
---
 lib/bb/ui/knotty.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index bb6d4cb..307886d 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -507,7 +507,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             termfilter.clearFooter()
             # ignore interrupted io
             if ioerror.args[0] == 4:
-                pass
+                continue
             sys.stderr.write(str(ioerror))
             if not params.observe_only:
                 _, error = server.runCommand(["stateForceShutdown"])
-- 
1.9.3

