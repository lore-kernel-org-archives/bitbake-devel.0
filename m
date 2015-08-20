Return-Path: <olof.johansson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 715B37689C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Aug 2015 22:51:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id A26A1180AF;
	Fri, 21 Aug 2015 00:51:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id Au-jzxkF3zJ4; Fri, 21 Aug 2015 00:51:45 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id 18ED6180B4;
	Fri, 21 Aug 2015 00:51:44 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id C9A1D12EE;
	Fri, 21 Aug 2015 00:51:44 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id BDEC1E82;
	Fri, 21 Aug 2015 00:51:44 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id BAA6C34005;
	Fri, 21 Aug 2015 00:51:44 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.3.342.0; Fri, 21 Aug 2015
	00:51:44 +0200
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 835159C68B; 
	Fri, 21 Aug 2015 00:51:44 +0200 (CEST)
Date: Fri, 21 Aug 2015 00:51:44 +0200
From: Olof Johansson <olof.johansson@axis.com>
To: Randy Witt <randy.e.witt@linux.intel.com>,
	<bitbake-devel@lists.openembedded.org>
Message-ID: <20150820225144.GB12937@axis.com>
References: <1440104436-12491-1-git-send-email-randy.e.witt@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <1440104436-12491-1-git-send-email-randy.e.witt@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Subject: Re: [PATCH] bitbake:main.py: Handle RuntimeError exception in list_extension_modules
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
X-List-Received-Date: Thu, 20 Aug 2015 22:51:49 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On 15-08-20 23:00 +0200, Randy Witt wrote:
> --- a/bitbake/lib/bb/main.py
> +++ b/bitbake/lib/bb/main.py
> @@ -60,7 +60,7 @@ def list_extension_modules(pkg, checkattr):
>              continue
>          try:
>              module = __import__(pkg.__name__, fromlist=[modulename])
> -        except (ImportError, SystemExit):
> +        except (ImportError, SystemExit, RuntimeError):
>              # If we can't import it, it's not valid
>              continue
>          module_if = getattr(module, modulename)

Wouldn't it be better to just skip naming the exceptions you want
to catch in this case? I.e.:

   try:
     module = __import__(...
   except:
     continue

"If we can't import it" ...

-- 
olofjn

