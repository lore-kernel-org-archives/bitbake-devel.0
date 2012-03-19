Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S9jAp-0002e4-E9
	for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 21:27:23 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 19 Mar 2012 13:18:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="119249088"
Received: from bbernhar-mobl.amr.corp.intel.com (HELO [10.7.198.147])
	([10.7.198.147])
	by orsmga001.jf.intel.com with ESMTP; 19 Mar 2012 13:18:33 -0700
Message-ID: <4F679499.3040105@linux.intel.com>
Date: Mon, 19 Mar 2012 13:18:33 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1331887394.git.dongxiao.xu@intel.com>
	<817e7641f1d1df38a4233addbb454a3280576da6.1331887394.git.dongxiao.xu@intel.com>
In-Reply-To: <817e7641f1d1df38a4233addbb454a3280576da6.1331887394.git.dongxiao.xu@intel.com>
Subject: Re: [PATCH 2/3] Hob: Fix advanced setting reparse mechanism
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 19 Mar 2012 20:27:23 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/03/12 01:48, Dongxiao Xu wrote:
> When judging if reparse is needed when change values in advanced
> setting, we need also include user's own defined variable pairs.
>
> [YOCTO #2121]
>
> Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>

Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>   lib/bb/ui/crumbs/hig.py |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
> index 67cc94e..8d73d5f 100644
> --- a/lib/bb/ui/crumbs/hig.py
> +++ b/lib/bb/ui/crumbs/hig.py
> @@ -453,6 +453,8 @@ class AdvancedSettingDialog (CrumbsDialog):
>           self.variables["PACKAGE_FORMAT"] = self.configuration.curr_package_format
>           self.variables["INCOMPATIBLE_LICENSE"] = self.configuration.incompat_license
>           self.variables["IMAGE_FSTYPES"] = self.configuration.image_fstypes
> +        for key in self.configuration.extra_setting.keys():
> +            self.variables[key] = self.configuration.extra_setting[key]
>           self.md5 = hashlib.md5(str(sorted(self.variables.items()))).hexdigest()
>           self.settings_changed = False
>

-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


