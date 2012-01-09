Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1RkKRH-0000ia-UC
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Jan 2012 19:59:24 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q09IpsLe022734
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 9 Jan 2012 10:51:54 -0800 (PST)
Received: from Macintosh-5.local (172.25.36.233) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Mon, 9 Jan 2012 10:51:54 -0800
Message-ID: <4F0B3746.4000303@windriver.com>
Date: Mon, 9 Jan 2012 12:51:50 -0600
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6;
	rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <1326128511.9278.24.camel@ted>
In-Reply-To: <1326128511.9278.24.camel@ted>
Subject: Re: [PATCH] bitbake: Add BBHandledException exception class
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
X-List-Received-Date: Mon, 09 Jan 2012 18:59:24 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

I noticed a typo in the patch below..  Otherwise it looks fine.

On 1/9/12 11:01 AM, Richard Purdie wrote:
> We have a problem knowing when to show the user debug information and
> when not to since the code has already shown the user suitable information
> about why a failure is occurring.
>
> This patch adds a bb.BBHandledException exception class which can be used
> to identify those exceptions which don't need further explanation to
> the user.
>
> This patch uses this class for the bb.providers exceptions and ensures the
> command handling code correctly filters the exceptions meaning that
>
> "bitbake invalid"
>
> now shows an simple error message and not a python traceback.
>
> [YOCTO #1141 partial]
>
> Signed-off-by: Richard Purdie<richard.purdie@linuxfoundation.org>
> ---
> diff --git a/bitbake/lib/bb/__init__.py b/bitbake/lib/bb/__init__.py
> index 5dc959c..e410eea 100644
> --- a/bitbake/lib/bb/__init__.py
> +++ b/bitbake/lib/bb/__init__.py
> @@ -27,6 +27,18 @@ import sys
>   if sys.version_info<  (2, 6, 0):
>       raise RuntimeError("Sorry, python 2.6.0 or later is required for this version of bitbake")
>
> +
> +class BBHandledException(Exception):
> +    """
> +    The big dillema for generic bitbake code is what information to give the user

dilemma I think

> +    when an exception occurs. Any exception inheriting this base exception class
> +    has already provided information to the user via some 'fired' message type such as
> +    an explicitly fired event using bb.fire, or a bb.error message. If bitbake
> +    encounters an expception derived from this class, no backtrace or other information

exception

> +    will be given to the user, its assumed the earlier event provided the relavent information.

relevant

> +    """
> +    pass
> +
>   import os
>   import logging
>
> diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
> index f236dac..2a3a3af 100644
> --- a/bitbake/lib/bb/command.py
> +++ b/bitbake/lib/bb/command.py
> @@ -98,9 +98,12 @@ class Command:
>               else:
>                   self.finishAsyncCommand("Exited with %s" % arg)
>               return False
> -        except Exception:
> +        except Exception as exc:
>               import traceback
> -            self.finishAsyncCommand(traceback.format_exc())
> +            if isinstance(exc, bb.BBHandledException):
> +                self.finishAsyncCommand("")
> +            else:
> +                self.finishAsyncCommand(traceback.format_exc())
>               return False
>
>       def finishAsyncCommand(self, msg=None, code=None):
> diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
> index 4543447..398c8ea 100644
> --- a/bitbake/lib/bb/providers.py
> +++ b/bitbake/lib/bb/providers.py
> @@ -28,10 +28,10 @@ import bb
>
>   logger = logging.getLogger("BitBake.Provider")
>
> -class NoProvider(Exception):
> +class NoProvider(bb.BBHandledException):
>       """Exception raised when no provider of a build dependency can be found"""
>
> -class NoRProvider(Exception):
> +class NoRProvider(bb.BBHandledException):
>       """Exception raised when no provider of a runtime dependency can be found"""
>
>
>
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel



