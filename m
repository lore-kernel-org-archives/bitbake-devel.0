Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ke.yu@intel.com>) id 1Qf15G-0006iz-Ek
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jul 2011 04:46:26 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 07 Jul 2011 19:41:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,496,1304319600"; d="scan'208";a="24729690"
Received: from kyu3-desk.ccr.corp.intel.com (HELO [10.238.154.176])
	([10.238.154.176])
	by orsmga001.jf.intel.com with ESMTP; 07 Jul 2011 19:41:27 -0700
Message-ID: <4E166E56.4040103@intel.com>
Date: Fri, 08 Jul 2011 10:41:26 +0800
From: Yu Ke <ke.yu@intel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US;
	rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To: Yu Ke <ke.yu@intel.com>
References: <cover.1309870780.git.ke.yu@intel.com>
	<2deaf320be6e019b2f2dad10463fb1bd77f98bbf.1309870780.git.ke.yu@intel.com>
In-Reply-To: <2deaf320be6e019b2f2dad10463fb1bd77f98bbf.1309870780.git.ke.yu@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] fetcher2: retry mirror if upstream checksum mismatch
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
X-List-Received-Date: Fri, 08 Jul 2011 02:46:26 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ping. any comment on this one?

on 2011-7-5 21:11, Yu Ke wrote:
> This patch is for [YOCTO #1085] fix.
>
> If the upstream fails a checksum, retry from the MIRROR before giving up.
> This will add more robust fetching if an upstream serves a bad file or webpage.
>
> fetching of distcc prior to the move from samba ->  googlecode is a good example
> of this.
>
> Signed-off-by: Yu Ke<ke.yu@intel.com>
> ---
>   bitbake/lib/bb/fetch2/__init__.py |   27 ++++++++++++++++-----------
>   1 files changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index e9a64c5..bb9dbbe 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -278,6 +278,15 @@ def verify_checksum(u, ud, d):
>       if BB_STRICT_CHECKSUM = "1" then return false as unmatched, otherwise return true as
>       matched
>       """
> +    # Only check the checksums if we've not seen this item before
> +    if os.path.exists(ud.donestamp):
> +        # Touch the done stamp file to show active use of the download
> +        try:
> +            os.utime(ud.donestamp, None)
> +        except:
> +            # Errors aren't fatal here
> +            pass
> +        return
>
>       if not ud.type in ["http", "https", "ftp", "ftps"]:
>           return
> @@ -300,6 +309,9 @@ def verify_checksum(u, ud, d):
>       if ud.sha256_expected != sha256data:
>           raise SHA256SumError(ud.localpath, ud.sha256_expected, sha256data, u)
>
> +    # Create the stamp to avoid duplicate checking
> +    open(ud.donestamp, 'w').close()
> +
>   def subprocess_setup():
>       import signal
>       # Python installs a SIGPIPE handler by default. This is usually not what
> @@ -932,6 +944,9 @@ class Fetch(object):
>                           if hasattr(m, "build_mirror_data"):
>                               m.build_mirror_data(u, ud, self.d)
>                           localpath = ud.localpath
> +                        # early checksum verify, so that if checksum mismatched,
> +                        # fetcher still have chance to fetch from mirror
> +                        verify_checksum(u, ud, self.d)
>
>                       except bb.fetch2.NetworkAccess:
>                           raise
> @@ -948,17 +963,7 @@ class Fetch(object):
>                   if not localpath or ((not os.path.exists(localpath)) and localpath.find("*") == -1):
>                       raise FetchError("Unable to fetch URL %s from any source." % u, u)
>
> -                if os.path.exists(ud.donestamp):
> -                    # Touch the done stamp file to show active use of the download
> -                    try:
> -                        os.utime(ud.donestamp, None)
> -                    except:
> -                        # Errors aren't fatal here
> -                        pass
> -                else:
> -                    # Only check the checksums if we've not seen this item before, then create the stamp
> -                    verify_checksum(u, ud, self.d)
> -                    open(ud.donestamp, 'w').close()
> +                verify_checksum(u, ud, self.d)
>
>               finally:
>                   bb.utils.unlockfile(lf)



