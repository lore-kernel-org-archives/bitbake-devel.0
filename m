Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1RaVOG-0001dd-J1
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Dec 2011 17:39:41 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 13 Dec 2011 08:31:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="95686071"
Received: from unknown (HELO [10.255.12.215]) ([10.255.12.215])
	by fmsmga001.fm.intel.com with ESMTP; 13 Dec 2011 08:31:15 -0800
Message-ID: <4EE77DD3.9030205@linux.intel.com>
Date: Tue, 13 Dec 2011 08:31:15 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:8.0) Gecko/20111115 Thunderbird/8.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1323656120.git.dongxiao.xu@intel.com>
	<a58b9713d301a6cbca3372f031a015365a57f295.1323656120.git.dongxiao.xu@intel.com>
In-Reply-To: <a58b9713d301a6cbca3372f031a015365a57f295.1323656120.git.dongxiao.xu@intel.com>
Subject: Re: [PATCH 01/10] command.py: Modify needcache value for certain functions
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
X-List-Received-Date: Tue, 13 Dec 2011 16:39:41 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



On 11/12/11 18:20, Dongxiao Xu wrote:
> for findConfigFiels() and findFilesMatchingInDir() functions, they
> don't need to parse all the bb files, thus setting the needcache
> value to be False.
> 
> Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>

If we can't rely on event_data to be consistent/up-to-date do we need to
keep it around? The comment around its creation implies we want/need the
copy of data.

This feels like we're working around on issue rather than fixing one.

Joshua

> ---
>  lib/bb/command.py |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/bb/command.py b/lib/bb/command.py
> index 83907f6..5dec6a9 100644
> --- a/lib/bb/command.py
> +++ b/lib/bb/command.py
> @@ -241,7 +241,7 @@ class CommandsAsync:
>  
>          command.cooker.findConfigFiles(varname)
>          command.finishAsyncCommand()
> -    findConfigFiles.needcache = True
> +    findConfigFiles.needcache = False
>  
>      def findFilesMatchingInDir(self, command, params):
>          """
> @@ -253,7 +253,7 @@ class CommandsAsync:
>  
>          command.cooker.findFilesMatchingInDir(pattern, directory)
>          command.finishAsyncCommand()
> -    findFilesMatchingInDir.needcache = True
> +    findFilesMatchingInDir.needcache = False
>  
>      def findConfigFilePath(self, command, params):
>          """

-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre


