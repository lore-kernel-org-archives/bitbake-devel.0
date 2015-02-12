Return-Path: <Maxin.John@enea.com>
Received: from mx-3.enea.com (sestofw01.enea.se [192.36.1.252])
	by mail.openembedded.org (Postfix) with SMTP id A315C72374
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Feb 2015 11:53:20 +0000 (UTC)
Received: from sestofb10.enea.se (172.21.3.145) by smtp.enea.com
	(172.21.1.209) with Microsoft SMTP Server id 14.3.224.2;
	Thu, 12 Feb 2015 12:53:16 +0100
Received: by sestofb10.enea.se (Postfix, from userid 4454)	id 9F9C32800CB;
	Thu, 12 Feb 2015 12:53:16 +0100 (CET)
Date: Thu, 12 Feb 2015 12:53:16 +0100
From: "Maxin B. John" <maxin.john@enea.com>
To: <bitbake-devel@lists.openembedded.org>
Message-ID: <20150212115316.GA8327@sestofb10.enea.se>
References: <1423489277-7774-1-git-send-email-maxin.john@enea.com>
MIME-Version: 1.0
In-Reply-To: <1423489277-7774-1-git-send-email-maxin.john@enea.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Received-SPF: None (SESTOEX03.enea.se: maxin.john@enea.com does not
	designate permitted sender hosts)
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
X-List-Received-Date: Thu, 12 Feb 2015 11:53:22 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

gentle ping..

On Mon, Feb 09, 2015 at 02:41:17PM +0100, Maxin B. John wrote:
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
> +
>      shutdown = 0
>  
>      gtkgui = gtkthread(shutdown)
> -- 
> 1.9.1

