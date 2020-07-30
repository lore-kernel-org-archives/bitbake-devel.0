Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 by mx.groups.io with SMTP id smtpd.web11.6140.1596108345586713902
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2020 04:25:45 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 147.11.1.11, mailfrom: liezhi.yang@windriver.com)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 06UBPiOY023499
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2020 04:25:44 -0700 (PDT)
Received: from [128.224.162.181] (128.224.162.181) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Jul 2020
 04:25:43 -0700
Subject: Re: [bitbake-devel] [PATCH 2/3] utils.py: get_file_layer(): Exit the loop when file is matched
From: "Robert Yang" <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
References: <20200730092342.7420-1-liezhi.yang@windriver.com>
 <16267D7686DB1B83.15129@lists.openembedded.org>
Message-ID: <ca0f277a-fa10-3766-a466-c85012c417b0@windriver.com>
Date: Thu, 30 Jul 2020 19:24:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <16267D7686DB1B83.15129@lists.openembedded.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

It's strange that the cover letter was lost. I used "git send-email 000*" to
send all of the patches including cover letter, but I didn't find it in
the mailing list. So I sent it here:

Subject: [PATCH 0/3] Fix performance issues for bitbake-layers show-recipes

The ruunning time of "bitbake-layers show-recipes" increased from 40s to 14min
after the following patch:

tinfoil: Simplify remote datastore connections

The patch 2 and 3 retores the time from 14min to 40s, which saves about 95% time.

# Updated: Patch 1 also improves the performance.

// Robert

The following changes since commit 20e9df57217c5f37817653d2c3d492f2d4d37623:

   lib/oe/reproducible.py: Fix git HEAD check (2020-07-29 11:37:31 +0100)

are available in the Git repository at:

   git://git.yoctoproject.org/poky-contrib rbt/bblayers
   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=rbt/bblayers

Robert Yang (3):
   cooker.py: Save prioritized BBFILES
   utils.py: get_file_layer(): Exit the loop when file is matched
   utils.py: get_file_layer(): Improve performance

  bitbake/lib/bb/cooker.py      |  2 +-
  bitbake/lib/bb/utils.py       | 15 +++++++++++----
  bitbake/lib/bblayers/query.py | 10 ++++++++--
  3 files changed, 20 insertions(+), 7 deletions(-)

// Robert

On 7/30/20 5:23 PM, Robert Yang wrote:
> This can make "$ bitbake-layers show-recipes" save about 60% time (14min ->
> 6min) in my build (more than 3000 recipes)
> 
> The command "bitbake-layers show-recipes" calls bb.utils.get_file_layer() with
> each recipe, and get_file_layer() compare the file with each item in BBFILES
> which makes it very time consuming when there are a lot of recipes and items in
> BBFILES. So exit when file is matched, it doesn't make sense to go on the loop
> when file is matched.
> 
> And use fnmatchcase to replace of fnmatch since the comparison should be
> case-sensitive.
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>   lib/bb/utils.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
> index 50032e50c..03568474d 100644
> --- a/bitbake/lib/bb/utils.py
> +++ b/bitbake/lib/bb/utils.py
> @@ -1494,9 +1494,10 @@ def get_file_layer(filename, d):
>       bbfiles = (d.getVar('BBFILES') or '').split()
>       bbfilesmatch = False
>       for bbfilesentry in bbfiles:
> -        if fnmatch.fnmatch(filename, bbfilesentry):
> +        if fnmatch.fnmatchcase(filename, bbfilesentry):
>               bbfilesmatch = True
>               result = path_to_layer(bbfilesentry)
> +            break
>   
>       if not bbfilesmatch:
>           # Probably a bbclass
> 
> 
> 
> 
