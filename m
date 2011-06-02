Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QSEBg-000204-No
	for bitbake-devel@lists.openembedded.org;
	Thu, 02 Jun 2011 22:08:12 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 02 Jun 2011 13:03:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,311,1304319600"; d="scan'208";a="12748508"
Received: from unknown (HELO [10.255.13.82]) ([10.255.13.82])
	by fmsmga001.fm.intel.com with ESMTP; 02 Jun 2011 13:03:54 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 02 Jun 2011 13:03:45 -0700
In-Reply-To: <6dda84cc0d5c63c7b09df0631d9082cbbcd2bd2f.1306947210.git.paul.eggleton@linux.intel.com>
References: <cover.1306947210.git.paul.eggleton@linux.intel.com>
	<6dda84cc0d5c63c7b09df0631d9082cbbcd2bd2f.1306947210.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.0.1 (3.0.1-1.fc15) 
Message-ID: <1307045035.2050.16.camel@scimitar>
Mime-Version: 1.0
Subject: Re: [RFC PATCH 2/2] bitbake-layers: handle skipped recipes
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
X-List-Received-Date: Thu, 02 Jun 2011 20:08:13 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2011-06-01 at 18:26 +0100, Paul Eggleton wrote:
> Report bbappends correctly for skipped recipes instead of reporting the
> bbappends as not having any matching recipe.
> 
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>

Cool! I know this depends on the 1st patch but

Signed-off-by: Joshua Lock <josh@linux.intel.com>

> ---
>  bitbake/bin/bitbake-layers |   24 +++++++++++++++++++-----
>  1 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
> index b6106cd..c58aee3 100755
> --- a/bitbake/bin/bitbake-layers
> +++ b/bitbake/bin/bitbake-layers
> @@ -81,6 +81,8 @@ class Commands(cmd.Cmd):
>          for pn in self.cooker_data.pkg_pn:
>              self.show_appends_for_pn(pn)
>  
> +        self.show_appends_for_skipped()
> +
>          self.show_appends_with_no_recipes()
>  
>      def show_appends_for_pn(self, pn):
> @@ -92,17 +94,27 @@ class Commands(cmd.Cmd):
>                                               self.cooker_data.pkg_pn)
>          best_filename = os.path.basename(best[3])
>  
> +        self.show_appends_output(filenames, best_filename)
> +
> +    def show_appends_for_skipped(self):
> +        filenames = [os.path.basename(f)
> +                    for f in self.cooker.skiplist.iterkeys()]
> +        self.show_appends_output(filenames, None, " (skipped)")
> +
> +    def show_appends_output(self, filenames, best_filename, name_suffix = ''):
>          appended, missing = self.get_appends_for_files(filenames)
>          if appended:
>              for basename, appends in appended:
> -                logger.info('%s:', basename)
> +                logger.info('%s%s:', basename, name_suffix)
>                  for append in appends:
>                      logger.info('  %s', append)
>  
> -            if best_filename in missing:
> -                logger.warn('%s: missing append for preferred version',
> -                            best_filename)
> -                self.returncode |= 1
> +            if best_filename:
> +                if best_filename in missing:
> +                    logger.warn('%s: missing append for preferred version',
> +                                best_filename)
> +                    self.returncode |= 1
> +
>  
>      def get_appends_for_files(self, filenames):
>          appended, notappended = set(), set()
> @@ -122,6 +134,8 @@ class Commands(cmd.Cmd):
>      def show_appends_with_no_recipes(self):
>          recipes = set(os.path.basename(f)
>                        for f in self.cooker_data.pkg_fn.iterkeys())
> +        recipes |= set(os.path.basename(f)
> +                      for f in self.cooker.skiplist.iterkeys())
>          appended_recipes = self.cooker_data.appends.iterkeys()
>          appends_without_recipes = [self.cooker_data.appends[recipe]
>                                     for recipe in appended_recipes

-- 
Joshua Lock
        Yocto Build System Monkey
        Intel Open Source Technology Centre



