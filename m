Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SHk6b-00057f-SB for bitbake-devel@lists.openembedded.org;
	Wed, 11 Apr 2012 01:04:10 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3AMspv2001490;
	Tue, 10 Apr 2012 23:54:51 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 01063-08; Tue, 10 Apr 2012 23:54:47 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q3AMshNL001484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Apr 2012 23:54:44 +0100
Message-ID: <1334098483.10826.86.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Saul Wold <sgw@linux.intel.com>
Date: Tue, 10 Apr 2012 23:54:43 +0100
In-Reply-To: <1334096422-28007-1-git-send-email-sgw@linux.intel.com>
References: <1334096422-28007-1-git-send-email-sgw@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/2] hig/builder: use the new which_terminal() function
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
X-List-Received-Date: Tue, 10 Apr 2012 23:04:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-04-10 at 15:20 -0700, Saul Wold wrote:
> Signed-off-by: Saul Wold <sgw@linux.intel.com>
> ---
>  lib/bb/ui/crumbs/builder.py |    7 ++++---
>  lib/bb/ui/crumbs/hig.py     |    3 ++-
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
> index a3410d4..e48afde 100755
> --- a/lib/bb/ui/crumbs/builder.py
> +++ b/lib/bb/ui/crumbs/builder.py
> @@ -37,6 +37,7 @@ from bb.ui.crumbs.hig import CrumbsMessageDialog, ImageSelectionDialog, \
>                               AdvancedSettingDialog, LayerSelectionDialog, \
>                               DeployImageDialog
>  from bb.ui.crumbs.persistenttooltip import PersistentTooltip
> +import bb.ui.crumbs.utils
>  
>  class Configuration:
>      '''Represents the data structure of configuration.'''
> @@ -946,10 +947,10 @@ class Builder(gtk.Window):
>              tmp_path = self.parameters.tmpdir
>              if os.path.exists(image_path) and os.path.exists(kernel_path) \
>                 and os.path.exists(source_env_path) and os.path.exists(tmp_path):
> -                cmdline = "/usr/bin/xterm -e "
> -                cmdline += "\" export OE_TMPDIR=" + tmp_path + "; "
> +                cmdline = bb.ui.crumbs.utils.which_terminal()
> +                cmdline += "\' bash -c \"export OE_TMPDIR=" + tmp_path + "; "
>                  cmdline += "source " + source_env_path + " " + os.getcwd() + "; "
> -                cmdline += "runqemu " + kernel_path + " " + image_path + "; bash\""
> +                cmdline += "runqemu " + kernel_path + " " + image_path + "\"\'"

This appears to do a bit more than you describe in the change message?
You also should check the return value of
bb.ui.crumbs.utils.which_terminal().

>                  subprocess.Popen(shlex.split(cmdline))
>              else:
>                  lbl = "<b>Path error</b>\nOne of your paths is wrong,"
> diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
> index 9adb281..508503c 100644
> --- a/lib/bb/ui/crumbs/hig.py
> +++ b/lib/bb/ui/crumbs/hig.py
> @@ -30,6 +30,7 @@ import shlex
>  from bb.ui.crumbs.hobcolor import HobColors
>  from bb.ui.crumbs.hobwidget import hcc, hic, HobViewTable, HobInfoButton, HobButton, HobAltButton, HobIconChecker
>  from bb.ui.crumbs.progressbar import HobProgressBar
> +import bb.ui.crumbs.utils
>  
>  """
>  The following are convenience classes for implementing GNOME HIG compliant
> @@ -737,7 +738,7 @@ class DeployImageDialog (CrumbsDialog):
>          if response_id == gtk.RESPONSE_YES:
>              combo_item = self.usb_combo.get_active_text()
>              if combo_item and combo_item != self.__dummy_usb__:
> -                cmdline = "/usr/bin/xterm -e "
> +                cmdline = bb.ui.crumbs.utils.which_terminal()
>                  cmdline += "\"sudo dd if=" + self.image_path + " of=" + combo_item + "; bash\""
>                  subprocess.Popen(args=shlex.split(cmdline))

So you remove the bash above but not here?

Cheers,

Richard




