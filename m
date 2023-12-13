Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CACAC4332F
	for <webhook@archiver.kernel.org>; Wed, 13 Dec 2023 15:00:43 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.37825.1702479638632811859
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Dec 2023 07:00:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=TDrymHIJ;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 936FC9C337F;
	Wed, 13 Dec 2023 10:00:37 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 9Pkc8Z1vMcPt; Wed, 13 Dec 2023 10:00:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E0E179C3381;
	Wed, 13 Dec 2023 10:00:36 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com E0E179C3381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702479636; bh=jnEzWVBn3ivvAPs1pcWv5qjv4/cwY096m4wXPRDxwmI=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=TDrymHIJoIuAWU/+y+rg7Mer31z39/bR2yBmOkCTh5j4ScSHLzGWytEafqQVFIzcD
	 EeCMhqY5U6xujHCgCrPitgqgxXTTrYOl0hvtkshI6KpHQrbnXgFdq7WOSYtwk6aRZV
	 XxxO07sZI00eJcA0CJXZva4eVKHkCKeNHgWVsnN0G40yGhJb3tymUrEzEY4GGX8Vqx
	 9COAc6CtJCxidAWZuImXIJDlAFnyQp4OTNj92xjsNaXRcylaqUo85pWHJG3lBxCGEs
	 N84sA3HpKRf3T7a/MHhALSqDN67DOZZHwIsZrxGKDNHcu+vkKgRsFcFQN1wM8X4j5t
	 hiNXI/wcLG76g==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id jcH1QwCsh0t1; Wed, 13 Dec 2023 10:00:36 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C157A9C337F;
	Wed, 13 Dec 2023 10:00:36 -0500 (EST)
Date: Wed, 13 Dec 2023 10:00:36 -0500 (EST)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: richard purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	toaster <toaster@lists.yoctoproject.org>
Message-ID: <321518811.78825.1702479636580.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <a4075d7dacd13a9c974c227c987ac112093204d7.camel@linuxfoundation.org>
References: <20231212215713.235263-1-marlon.rodriguez-garcia@savoirfairelinux.com> <a4075d7dacd13a9c974c227c987ac112093204d7.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [Toaster] [PATCH] toaster: Added dataTables
 library to include sorting and pagination for table element
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4562 (ZimbraWebClient - FF119 (Linux)/8.8.15_GA_4570)
Thread-Topic: toaster: Added dataTables library to include sorting and pagination for table element
Thread-Index: j7fgqGl7rBU1WUVQ8e2n3VzjFHUF0w==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Dec 2023 15:00:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15663

The image missing is a version issue, i will update with a new patch with the latest version, the default value of entries for page  in the table seems correct , i will include that on the patch as well.
In relation to the queue i will work on that in a different patch 

----- Original Message -----
From: "richard purdie" <richard.purdie@linuxfoundation.org>
To: "Marlon Rodriguez Garcia" <marlon.rodriguez-garcia@savoirfairelinux.com>, "bitbake-devel" <bitbake-devel@lists.openembedded.org>, "toaster" <toaster@lists.yoctoproject.org>
Sent: Wednesday, December 13, 2023 8:11:06 AM
Subject: Re: [bitbake-devel] [Toaster] [PATCH] toaster: Added dataTables library to include sorting and pagination for table element

On Tue, 2023-12-12 at 16:57 -0500, Marlon Rodriguez Garcia wrote:
> Added jquery.dataTables to customize table rendering in section
> "Import eventlogs".
> This library includes the following: sorting, pagination, search and
> CSS styles.

Thanks, this looks good. I noticed that there are a couple of static
images missing:

http://localhost:8000/static/images/sort_asc.png
http://localhost:8000/static/images/sort_both.png

I also wondered about something like this:

diff --git a/bitbake/lib/toaster/toastergui/templates/command_line_builds.html b/bitbake/lib/toaster/toastergui/templates/command_line_builds.html
index 25a5e8062fb..c9fefef01a2 100644
--- a/bitbake/lib/toaster/toastergui/templates/command_line_builds.html
+++ b/bitbake/lib/toaster/toastergui/templates/command_line_builds.html
@@ -197,7 +197,7 @@ $( "#form_file").on( "submit", function( event ) {
 });
 
 $(document).ready( function () {
-    $('#eventlog-table').DataTable();
+    $('#eventlog-table').DataTable({order: [[0, 'desc']], "pageLength": 50})
 });
 
 </script>

to set the default sort and show a few more file entries per page. Not
sure if I have that in the right place!

I did also realise the issue I was trying to explain yesterday.

If you start an import of a commandline build, then try and import a
second one whilst the first is still running, it crashes. Is there
something we can do about that so they queue?

Cheers,

Richard




-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#15659): https://lists.openembedded.org/g/bitbake-devel/message/15659
Mute This Topic: https://lists.openembedded.org/mt/103148397/7896800
Group Owner: bitbake-devel+owner@lists.openembedded.org
Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/leave/12674656/7896800/2042766072/xyzzy [marlon.rodriguez-garcia@savoirfairelinux.com]
-=-=-=-=-=-=-=-=-=-=-=-

