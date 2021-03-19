Received: from cpanel8.indieserve.net (cpanel8.indieserve.net [199.212.143.3])
 by mx.groups.io with SMTP id smtpd.web09.631.1616176044957486475
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Mar 2021 10:47:25 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: crashcourse.ca, ip: 199.212.143.3, mailfrom: rpjday@crashcourse.ca)
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:52840 helo=fedora)
	by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1lNJDW-00FeWC-Ni; Fri, 19 Mar 2021 13:47:23 -0400
Date: Fri, 19 Mar 2021 13:47:18 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 1/2] build: Add file_stale_stamps function
In-Reply-To: <20210319173012.229109-1-richard.purdie@linuxfoundation.org>
Message-ID: <6398f1e1-5ac-e659-a468-9fa73fdbdd66@crashcourse.ca>
References: <20210319173012.229109-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel8.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel8.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel8.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Content-Type: text/plain; charset=US-ASCII

On Fri, 19 Mar 2021, Richard Purdie wrote:

> Add a new function which compares the stamp filename we want (including
> taskhash) with what is in the stamp directory (using the clean mask).
> This tells us which stamp files are stale and are due to be rerun.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/build.py | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/lib/bb/build.py b/lib/bb/build.py
> index f4f897e41a..b2715fc530 100644
> --- a/lib/bb/build.py
> +++ b/lib/bb/build.py
> @@ -854,6 +854,23 @@ def make_stamp(task, d, file_name = None):
>          file_name = d.getVar('BB_FILENAME')
>          bb.parse.siggen.dump_sigtask(file_name, task, stampbase, True)
>
> +def find_stale_stamps(task, d, file_name=None):

  subject does not match function name.

rday
