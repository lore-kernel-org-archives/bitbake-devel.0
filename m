Return-Path: <laurent.joli-ext@sagemcom.com>
Received: from sgc-chev-fe1.sgc.gmessaging.net
	(sgc-chev-fe1.sgc.gmessaging.net [194.51.18.91])
	by mail.openembedded.org (Postfix) with ESMTP id 8368F65E2F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Apr 2014 15:16:14 +0000 (UTC)
Received: from sgc-chev-fe1.sgc.gmessaging.net (localhost.localdomain
	[127.0.0.1])
	by localhost.sgc.gmessaging.net (Postfix) with SMTP id A8827578E1B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Apr 2014 17:16:13 +0200 (CEST)
Received: from EXDRUEARSGC008.eq1sgc.local (unknown [10.67.4.133])
	by sgc-chev-fe1.sgc.gmessaging.net (Postfix) with ESMTP id 88B3C578E11
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Apr 2014 17:16:13 +0200 (CEST)
Received: from [10.66.128.23] (10.66.128.23) by webmail-int.sagemcom.com
	(10.67.4.133) with Microsoft SMTP Server (TLS) id 14.3.158.1;
	Fri, 11 Apr 2014 17:16:02 +0200
Message-ID: <53480732.1020604@sagemcom.com>
Date: Fri, 11 Apr 2014 17:16:02 +0200
From: Laurent Joli <laurent.joli-ext@sagemcom.com>
Organization: Sagemcom
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
X-Enigmail-Version: 1.4.6
X-Originating-IP: [10.66.128.23]
Subject: [yocto] bitbake co from SVN with authentication
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
Reply-To: laurent.joli-ext@sagemcom.com
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 11 Apr 2014 15:16:18 -0000
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit

Hello,

I am try to checkout some file from a SVN with authentification. But
bitbake say that :


ERROR: Function failed: Fetcher failure: Fetch command failed with exit
code 1, output:
svn: E170001: Unable to connect to a repository at URL 'http://XXX'
svn: E170001: OPTIONS of 'http://XXX': authorization failed: Could not
authenticate to server: ignored Negotiate challenge, rejected Basic
challenge

ERROR: Logfile of failure stored in:
/home/g179256/yocto/XX/armv7a-vfp-neon-poky-linux-gnueabi/ti-dcg3-app/loadNG-r0/temp/log.do_fetch.6211
Log data follows:
| DEBUG: Executing python function do_fetch
| DEBUG: Executing python function base_do_fetch
| DEBUG: Fetcher accessed the network with the command /usr/bin/env svn
--non-interactive --trust-server-cert info --no-auth-cache http://XXX
| DEBUG: Running export SSH_AGENT_PID="3606"; export
SSH_AUTH_SOCK="/tmp/ssh-zEFWxgcc3553/agent.3553"; export http_proxy=""; 
export HOME="/home/g179256"; LANG=C LC_ALL=C /usr/bin/env svn
--non-interactive --trust-server-cert info --no-auth-cache http://XXX
| DEBUG: Python function base_do_fetch finished
| DEBUG: Python function do_fetch finished
| ERROR: Function failed: Fetcher failure: Fetch command failed with
exit code 1, output:
| svn: E170001: Unable to connect to a repository at URL 'http://XXX'
| svn: E170001: OPTIONS of 'http://XXX': authorization failed: Could not
authenticate to server: ignored Negotiate challenge, rejected Basic
challenge
|
ERROR: Task 0
(/home/g179256/yocto/../meta-layer-third-party/meta-custom/recipes-plc/ti-dcg3-app/ti-dcg3-app_loadNG.bb,
do_fetch) failed with exit code '1'
NOTE: Tasks Summary: Attempted 236 tasks of which 2 didn't need to be
rerun and 1 failed.

Summary: 1 task failed:
 
/home/g179256/yocto_urd3/../meta-layer-third-party/meta-custom/recipes-plc/ti-dcg3-app/ti-dcg3-app_loadNG.bb,
do_fetch
Summary: There were 32 WARNING messages shown.
Summary: There was 1 ERROR message shown, returning a non-zero exit code.

Why bitbake does not ask me my username and my password ?

Best regards,
-----------
Laurent JOLI

#
" Ce courriel et les documents qui lui sont joints peuvent contenir des
informations confidentielles ou ayant un caractè privéS'ils ne vous sont
pas destiné nous vous signalons qu'il est strictement interdit de les
divulguer, de les reproduire ou d'en utiliser de quelque maniè que ce
soit le contenu. Si ce message vous a é transmis par erreur, merci d'en
informer l'expéteur et de supprimer imméatement de votre systè
informatique ce courriel ainsi que tous les documents qui y sont attaché"


                               ******

" This e-mail and any attached documents may contain confidential or
proprietary information. If you are not the intended recipient, you are
notified that any dissemination, copying of this e-mail and any attachments
thereto or use of their contents by any means whatsoever is strictly
prohibited. If you have received this e-mail in error, please advise the
sender immediately and delete this e-mail and all attached documents
from your computer system."
#


