Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5D598733CB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Feb 2015 17:03:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t1DH1t1M004449; Fri, 13 Feb 2015 17:03:00 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id YLNikqBfYv8S; Fri, 13 Feb 2015 17:03:00 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t1DH2jdO004505
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Feb 2015 17:02:56 GMT
Message-ID: <1423846965.20217.95.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Maxin B. John" <maxin.john@enea.com>
Date: Fri, 13 Feb 2015 17:02:45 +0000
In-Reply-To: <1423489277-7774-1-git-send-email-maxin.john@enea.com>
References: <1423489277-7774-1-git-send-email-maxin.john@enea.com>
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2] depexp.py: Fix segfault if DISPLAY is not set
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
X-List-Received-Date: Fri, 13 Feb 2015 17:03:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2015-02-09 at 14:41 +0100, Maxin B. John wrote:
> bitbake -g -u depexp <package> segfaults when DISPLAY is not set
> properly. Fix it with a proper check.
> 
> [YOCTO #7299]
> 
> Signed-off-by: Maxin B. John <maxin.john@enea.com>
> ---
>  bitbake/lib/bb/ui/depexp.py | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/bitbake/lib/bb/ui/depexp.py b/bitbake/lib/bb/ui/depexp.py
> index 0c71a3e..1b8f0b2 100644
> --- a/bitbake/lib/bb/ui/depexp.py
> +++ b/bitbake/lib/bb/ui/depexp.py
> @@ -17,6 +17,7 @@
>  # with this program; if not, write to the Free Software Foundation, Inc.,
>  # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>  
> +import sys
>  import gobject
>  import gtk
>  import Queue
> @@ -215,6 +216,12 @@ def main(server, eventHandler, params):
>          print("XMLRPC Fault getting commandline:\n %s" % x)
>          return
>  
> +    try:
> +        gtk.init_check()
> +    except:
> +        sys.stderr.write("Please set DISPLAY variable before running this command \n")
> +        return

Sorry about the delay in replying. Its usually bad form to put generic
except clauses into python. Is there a specific exception we should be
trapping here?

Cheers,

Richard


