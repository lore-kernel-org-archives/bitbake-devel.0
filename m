Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 8311A60E07
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Apr 2014 15:20:39 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 04 Apr 2014 08:15:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,795,1389772800"; d="scan'208";a="514915224"
Received: from davidllo-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.120.87])
	by orsmga002.jf.intel.com with ESMTP; 04 Apr 2014 08:20:38 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Alex DAMIAN <alexandru.damian@intel.com>
Date: Fri, 04 Apr 2014 16:20:36 +0100
Message-ID: <2189102.coGc3LNv3A@peggleto-mobl5.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.12.3 (Linux/3.13.7-200.fc20.x86_64; KDE/4.12.3; x86_64; ; )
In-Reply-To: <8ab63a668e94e4179850e4e8d901e719d071d3bc.1396620556.git.alexandru.damian@intel.com>
References: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
	<8ab63a668e94e4179850e4e8d901e719d071d3bc.1396620556.git.alexandru.damian@intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 03/14] toaster: do not load all available timezones
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
X-List-Received-Date: Fri, 04 Apr 2014 15:20:39 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 04 April 2014 15:10:42 Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
> 
> This patch makes sure that we only load pytz-recognized
> timezones. Pytz is used to transform the timezone information
> for the database queries, and needs to be able to deal with
> the TIME_ZONE value that we set up.
> 
> [YOCTO #6093]
> 
> Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> ---
>  lib/toaster/toastermain/settings.py | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/toaster/toastermain/settings.py
> b/lib/toaster/toastermain/settings.py index e26ee3c..e39b4cb 100644
> --- a/lib/toaster/toastermain/settings.py
> +++ b/lib/toaster/toastermain/settings.py
> @@ -64,7 +64,13 @@ else:
>      for dirpath, dirnames, filenames in os.walk(ZONEINFOPATH):
>          for fn in filenames:
>              filepath = os.path.join(dirpath, fn)
> -            zonefilelist[hashlib.md5(open(filepath).read()).hexdigest()] =
> filepath.lstrip(ZONEINFOPATH).strip() +            try:
> +                import pytz
> +                zonename = filepath.lstrip(ZONEINFOPATH).strip()
> +                if pytz.timezone(zonename) is not None:
> +                   
> zonefilelist[hashlib.md5(open(filepath).read()).hexdigest()] = zonename 
> +          except Exception:
> +                pass

Please do not do blanket exception catching like this. You need to catch the 
exact class of exception you expect to receive.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

