Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC91C4332F
	for <webhook@archiver.kernel.org>; Wed, 13 Dec 2023 13:11:12 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.35681.1702473069523617940
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Dec 2023 05:11:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IpWcn3Wz;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c3ca9472dso48216615e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 Dec 2023 05:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702473068; x=1703077868; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqFtg+yKnToou6V2cXWgEh8jfDcy/YnKj3vimJ5w76w=;
        b=IpWcn3Wz1d+5O0TvxOmIb+eEeLk24Cj6mTjow5jRQL0O32M0XmNnVokp20NG20P9Wb
         msEpz70lN9tjZHmBbazyXbFAXbTLXO++vYgh7Ltz4iNGSP5cLcB4aXfjE/zuA4mf1sFN
         cz2j6gOE9Vk+YCYvS2nCnt8ru8UzVUZa2oRYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702473068; x=1703077868;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pqFtg+yKnToou6V2cXWgEh8jfDcy/YnKj3vimJ5w76w=;
        b=WLd8p2lTSCcdQXjJ93ukWcYZbvITabbULVGoo/+nazE1AiZhxyKAoUDdi6kXt/y3Hg
         eTjM5qX4qdvEUq+yNGVYZuN972+BdKavdpI6gwOHLBP4xI9RtyDU1mN3G8k4wL8g/mh+
         7E7SaJzxIgCokoTZN5d7raAtrLCZOK46ipHCGKRxw/2xqtjqsgKgWe8jAQo/g0vEGhPx
         i8OEC+rfwq9NJ0Ar59/QTEyehQsIdiTneEo8YoTOZvjFl+RTJbWZnixFeTrqOoArcF53
         8T0RxoNL5LDjTa9fKo6m9kCeBp8WJFRZxJ7pcCIcAmVqlxX3iVrGE/EVA27wwcuzvS+5
         s59A==
X-Gm-Message-State: AOJu0YzcWTAP+dldmyVUCT0/GDFD/DVAjqvX58FqiOueDyCPJgblQb0u
	15+sjNpgvrDatALi1ytV3tYYrg==
X-Google-Smtp-Source: AGHT+IEPHFI1XqNA0EQ5NmUTIKA0BxPXqKCX63ws47wRQino2iTpFVL8n0LBGUuFz3EcPPI+KQjiqw==
X-Received: by 2002:a7b:c3d0:0:b0:40c:3133:6f06 with SMTP id t16-20020a7bc3d0000000b0040c31336f06mr2880455wmj.154.1702473067827;
        Wed, 13 Dec 2023 05:11:07 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:7173:bb34:6d69:83d3? ([2001:8b0:aba:5f3c:7173:bb34:6d69:83d3])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b0040c1d2c6331sm20556259wms.32.2023.12.13.05.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:11:07 -0800 (PST)
Message-ID: <a4075d7dacd13a9c974c227c987ac112093204d7.camel@linuxfoundation.org>
Subject: Re: [Toaster] [PATCH] toaster: Added dataTables library to include
 sorting and pagination for table element
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>, 
	bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
Date: Wed, 13 Dec 2023 13:11:06 +0000
In-Reply-To: <20231212215713.235263-1-marlon.rodriguez-garcia@savoirfairelinux.com>
References: 
	<20231212215713.235263-1-marlon.rodriguez-garcia@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Dec 2023 13:11:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15659

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

diff --git a/bitbake/lib/toaster/toastergui/templates/command_line_builds.h=
tml b/bitbake/lib/toaster/toastergui/templates/command_line_builds.html
index 25a5e8062fb..c9fefef01a2 100644
--- a/bitbake/lib/toaster/toastergui/templates/command_line_builds.html
+++ b/bitbake/lib/toaster/toastergui/templates/command_line_builds.html
@@ -197,7 +197,7 @@ $( "#form_file").on( "submit", function( event ) {
 });
=20
 $(document).ready( function () {
-    $('#eventlog-table').DataTable();
+    $('#eventlog-table').DataTable({order: [[0, 'desc']], "pageLength": 50=
})
 });
=20
 </script>

to set the default sort and show a few more file entries per page. Not
sure if I have that in the right place!

I did also realise the issue I was trying to explain yesterday.

If you start an import of a commandline build, then try and import a
second one whilst the first is still running, it crashes. Is there
something we can do about that so they queue?

Cheers,

Richard



