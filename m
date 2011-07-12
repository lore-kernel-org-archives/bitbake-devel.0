Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QgasH-0003iK-Ag for bitbake-devel@lists.openembedded.org;
	Tue, 12 Jul 2011 13:11:33 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6CB7XlF019367;
	Tue, 12 Jul 2011 12:07:33 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 18595-03; Tue, 12 Jul 2011 12:07:29 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6CB7PtF019361
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Jul 2011 12:07:27 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Yu Ke <ke.yu@intel.com>
In-Reply-To: <2deaf320be6e019b2f2dad10463fb1bd77f98bbf.1309870780.git.ke.yu@intel.com>
References: <cover.1309870780.git.ke.yu@intel.com>
	<2deaf320be6e019b2f2dad10463fb1bd77f98bbf.1309870780.git.ke.yu@intel.com>
Date: Tue, 12 Jul 2011 10:41:00 +0100
Message-ID: <1310463660.20015.1030.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
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
X-List-Received-Date: Tue, 12 Jul 2011 11:11:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-07-05 at 21:11 +0800, Yu Ke wrote:
> This patch is for [YOCTO #1085] fix.
> 
> If the upstream fails a checksum, retry from the MIRROR before giving up.
> This will add more robust fetching if an upstream serves a bad file or webpage.
> 
> fetching of distcc prior to the move from samba -> googlecode is a good example
> of this.
> 
> Signed-off-by: Yu Ke <ke.yu@intel.com>
> ---
>  bitbake/lib/bb/fetch2/__init__.py |   27 ++++++++++++++++-----------
>  1 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index e9a64c5..bb9dbbe 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -278,6 +278,15 @@ def verify_checksum(u, ud, d):
>      if BB_STRICT_CHECKSUM = "1" then return false as unmatched, otherwise return true as
>      matched
>      """
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
>      if not ud.type in ["http", "https", "ftp", "ftps"]:
>          return
> @@ -300,6 +309,9 @@ def verify_checksum(u, ud, d):
>      if ud.sha256_expected != sha256data:
>          raise SHA256SumError(ud.localpath, ud.sha256_expected, sha256data, u)
>  
> +    # Create the stamp to avoid duplicate checking
> +    open(ud.donestamp, 'w').close()
> +
>  def subprocess_setup():
>      import signal
>      # Python installs a SIGPIPE handler by default. This is usually not what
> @@ -932,6 +944,9 @@ class Fetch(object):
>                          if hasattr(m, "build_mirror_data"):
>                              m.build_mirror_data(u, ud, self.d)
>                          localpath = ud.localpath
> +                        # early checksum verify, so that if checksum mismatched,
> +                        # fetcher still have chance to fetch from mirror
> +                        verify_checksum(u, ud, self.d)
>  
>                      except bb.fetch2.NetworkAccess:
>                          raise
> @@ -948,17 +963,7 @@ class Fetch(object):
>                  if not localpath or ((not os.path.exists(localpath)) and localpath.find("*") == -1):
>                      raise FetchError("Unable to fetch URL %s from any source." % u, u)
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
>              finally:
>                  bb.utils.unlockfile(lf)

Hi Ke,

I find this patch a little confusing since you're altering what the
verify_checksum() function does to including something else which is
partly unrelated.

I like the idea of moving that logic to a separate function but perhaps
we need a new one which then calls verify_checksum() rather than having
the two functionalities merged together?

Perhaps an update_stamps() function would be a good name for this?

Cheers,

Richard



