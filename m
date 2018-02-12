Return-Path: <jan.kiszka@siemens.com>
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
	by mail.openembedded.org (Postfix) with ESMTP id DA2086025E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Feb 2018 07:57:40 +0000 (UTC)
Received: from mail3.siemens.de (mail3.siemens.de [139.25.208.14])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w1C7vevG004450
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Feb 2018 08:57:40 +0100
Received: from [167.87.31.168] ([167.87.31.168])
	by mail3.siemens.de (8.15.2/8.15.2) with ESMTP id w1C7veL8017784
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Feb 2018 08:57:40 +0100
Resent-From: Jan Kiszka <jan.kiszka@siemens.com>
Resent-To: bitbake-devel@lists.openembedded.org
Resent-Date: Mon, 12 Feb 2018 08:57:40 +0100
Resent-Message-ID: <5e790e25-a548-1df1-cf53-d7477ed6e4df@siemens.com>
Resent-User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de;
	rv:1.8.1.12) Gecko/20080226 SUSE/2.0.0.12-1.1
	Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
To: "[ext] Henning Schild" <henning.schild@siemens.com>,
	<bitbake-devel@lists.openembedded.org>
References: <20171212144443.30618-1-henning.schild@siemens.com>
	<20171212151203.31408-1-henning.schild@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <027e7d81-b55a-ce05-9188-c34376a78197@siemens.com>
Date: Mon, 12 Feb 2018 08:40:47 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
	Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
In-Reply-To: <20171212151203.31408-1-henning.schild@siemens.com>
MIME-Version: 1.0
Cc: isar-users@googlegroups.com
Subject: Re: [PATCH v2] fetch/git: add support for disabling shared clones on unpack
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
X-List-Received-Date: Mon, 12 Feb 2018 07:57:41 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2017-12-12 16:12, [ext] Henning Schild wrote:
> By default the unpacker will create a "shared" clone when cloning from
> the DL_DIR to the WORKDIR. This patch introduces an option to control
> that behaviour. Probably something that hardly anyone would want to do.
> 
> Imagine some recipe steps are executed in a namespace that is different
> from the one your downloader and unpacker ran in. (chroot) Because a
> "shared" clone has an absolute reference to its "alternate" you now
> have to make that "alternate" visible in that new namespace (chroot) at
> the exact place.
> 
> With this patch you can unpack "noshared" and get a stand-alone copy.
> This copy will also work if the "alternate" is not visible or existant.

s/existant/existent/

> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  lib/bb/fetch2/git.py | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 5ef8cd69..7b7f02b2 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -53,6 +53,13 @@ Supported SRC_URI options are:
>     For local git:// urls to use the current branch HEAD as the revision for use with
>     AUTOREV. Implies nobranch.
>  
> +- noshared
> +   When unpacking do not clone with the parameter "--shared". This option will
> +   allow the unpacked copy to work stand-alone i.e. if your recipe runs in a
> +   chroot where the "alternate" can not be found. Setting this will increase
> +   the unpack-time and the disk-usage.
> +   The default is "0", set noshared=1 if needed.
> +
>  """
>  
>  #Copyright (C) 2005 Richard Purdie
> @@ -159,6 +166,8 @@ class Git(FetchMethod):
>  
>          ud.nobranch = ud.parm.get("nobranch","0") == "1"
>  
> +        ud.noshared = ud.parm.get("noshared","0") == "1"
> +
>          # usehead implies nobranch
>          ud.usehead = ud.parm.get("usehead","0") == "1"
>          if ud.usehead:
> @@ -176,7 +185,9 @@ class Git(FetchMethod):
>          if len(branches) != len(ud.names):
>              raise bb.fetch2.ParameterError("The number of name and branch parameters is not balanced", ud.url)
>  
> -        ud.cloneflags = "-s -n"
> +        ud.cloneflags = "-n"
> +        if not ud.noshared:
> +            ud.cloneflags += " -s"
>          if ud.bareclone:
>              ud.cloneflags += " --mirror"
>  
> 

Ping on this feature: Could we get some feedback if/how such a
configuration option would be acceptable for upstream? We'd like to
avoid having to patch or fork bitbake downstream for such a tiny change.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

