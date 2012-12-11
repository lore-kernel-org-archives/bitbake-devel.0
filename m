Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TiSIx-0007LU-3g for bitbake-devel@lists.openembedded.org;
	Tue, 11 Dec 2012 17:03:35 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qBBFn0x6012739;
	Tue, 11 Dec 2012 15:49:00 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 11838-10; Tue, 11 Dec 2012 15:48:56 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qBBFmrUN012733
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2012 15:48:55 GMT
Message-ID: <1355240932.6771.34.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Tue, 11 Dec 2012 15:48:52 +0000
In-Reply-To: <1355233468-10679-1-git-send-email-cristiana.voicu@intel.com>
References: <1355233468-10679-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PatchV2] hob/bitbake: custom image is now using the base image
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
X-List-Received-Date: Tue, 11 Dec 2012 16:03:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-12-11 at 15:44 +0200, Cristiana Voicu wrote:
> Till now, a custom image made in Hob was using only the packages from
> the base image. Now it is using everything declared in the base image.
> Also next to hob-image.bb, it creates another .bb file which is used
> in building process. Those images are ignored by git.
> 
> [YOCTO #2601]
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  .gitignore                                  |    1 +
>  bitbake/lib/bb/command.py                   |   10 ++++++++++
>  bitbake/lib/bb/cooker.py                    |   20 ++++++++++++++++++++
>  bitbake/lib/bb/ui/crumbs/builder.py         |    6 +++++-
>  bitbake/lib/bb/ui/crumbs/hobeventhandler.py |   10 +++++++++-
>  bitbake/lib/bb/ui/crumbs/hoblistmodel.py    |    6 ++++++
>  6 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index 88c91f6..003f09a 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -15,3 +15,4 @@ meta-*
>  *~
>  !meta-yocto
>  !meta-yocto-bsp
> +hob-image-*.bb
> diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
> index 3f28bca..28b4c5d 100644
> --- a/bitbake/lib/bb/command.py
> +++ b/bitbake/lib/bb/command.py
> @@ -197,6 +197,16 @@ class CommandsSync:
>          filterfunc = params[0]
>          bb.parse.parse_py.ConfHandler.confFilters.append(filterfunc)
>  
> +    def matchFile(self, command, params):
> +        fMatch = params[0]
> +        return command.cooker.matchFile(fMatch)
> +
> +    def generateNewImage(self, command, params):
> +        image = params[0]
> +        base_image = params[1]
> +        package_queue = params[2]
> +        return command.cooker.generateNewImage(image, base_image, package_queue)
> +
>  class CommandsAsync:
>      """
>      A class of asynchronous commands
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 6b58f91..2338b31 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -1188,6 +1188,26 @@ class BBCooker:
>  
>          self.server_registration_cb(buildTargetsIdle, rq)
>  
> +    def generateNewImage(self, image, base_image, package_queue):
> +        '''
> +        Create a new image with a "require" base_image statement
> +        '''
> +        image_name = os.path.splitext(image)[0]
> +        timestr = time.strftime("-%Y%m%d-%H%M%S")
> +        dest = image_name + str(timestr) + ".bb"
> +
> +        with open(dest, "w") as imagefile:
> +            imagefile.write("inherit image\n")

Do we need the above line? Doesn't the original image do this for us?


Looks good to me otherwise though, much better than the previous
version!

Cheers,

Richard



