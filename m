Return-Path: <frazer.clews@codethink.co.uk>
Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk
	[78.40.148.184])
	by mail.openembedded.org (Postfix) with ESMTP id 965E760AE0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jan 2020 16:49:31 +0000 (UTC)
Received: from [167.98.27.226] (helo=localhost.localdomain)
	by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
	id 1iwpN4-0007yo-Uw for <bitbake-devel@lists.openembedded.org> ;
	Wed, 29 Jan 2020 15:35:15 +0000
To: bitbake-devel@lists.openembedded.org
References: <20200114144606.163629-1-frazer.clews@codethink.co.uk>
From: Frazer Leslie Clews <frazer.clews@codethink.co.uk>
Message-ID: <6c85422c-470f-3353-5926-ab6d786fcca7@codethink.co.uk>
Date: Wed, 29 Jan 2020 15:35:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
	Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200114144606.163629-1-frazer.clews@codethink.co.uk>
Subject: Re: [PATCH] replaced deprecated method warn() with warning()
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
X-List-Received-Date: Fri, 31 Jan 2020 09:28:00 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US

Hi

I was wondering if anyone has had a chance to look at this, or is this 
not wanted?

KInd regards

Frazer

On 14/01/2020 14:46, frazer.clews@codethink.co.uk wrote:
> From: Frazer Clews <frazer.clews@codethink.co.uk>
>
> lib: Removed the deprecated methods as it will only cause problems later on,
> and since warn() just calls warning(), it shouldn't change anything
>
> Signed-off-by: Frazer Clews <frazer.clews@codethink.co.uk>
> ---
>   lib/bb/cooker.py                                        | 2 +-
>   lib/toaster/bldcontrol/management/commands/runbuilds.py | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index b74affa7..911805a6 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -1788,7 +1788,7 @@ class CookerCollectFiles(object):
>                   # When constructing an older style single regex, it's possible for BBMASK
>                   # to end up beginning with '|', which matches and masks _everything_.
>                   if mask.startswith("|"):
> -                    collectlog.warn("BBMASK contains regular expression beginning with '|', fixing: %s" % mask)
> +                    collectlog.warning("BBMASK contains regular expression beginning with '|', fixing: %s" % mask)
>                       mask = mask[1:]
>                   try:
>                       re.compile(mask)
> diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
> index 50ec4098..19f659ec 100644
> --- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
> +++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
> @@ -168,17 +168,17 @@ class Command(BaseCommand):
>           try:
>               self.cleanup()
>           except Exception as e:
> -            logger.warn("runbuilds: cleanup exception %s" % str(e))
> +            logger.warning("runbuilds: cleanup exception %s" % str(e))
>   
>           try:
>               self.archive()
>           except Exception as e:
> -            logger.warn("runbuilds: archive exception %s" % str(e))
> +            logger.warning("runbuilds: archive exception %s" % str(e))
>   
>           try:
>               self.schedule()
>           except Exception as e:
> -            logger.warn("runbuilds: schedule exception %s" % str(e))
> +            logger.warning("runbuilds: schedule exception %s" % str(e))
>   
>       def handle(self, **options):
>           pidfile_path = os.path.join(os.environ.get("BUILDDIR", "."),

