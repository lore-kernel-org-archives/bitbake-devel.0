Return-Path: <olof.johansson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 76A7C76B37
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Aug 2015 12:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 1D96F181C3;
	Thu, 20 Aug 2015 14:55:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id LZWdQZwdQ3qt; Thu, 20 Aug 2015 14:55:13 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id 497C8180AF;
	Thu, 20 Aug 2015 14:55:13 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 01BEC144E;
	Thu, 20 Aug 2015 14:55:13 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id E4E13FD6;
	Thu, 20 Aug 2015 14:55:12 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id E1ED434005;
	Thu, 20 Aug 2015 14:55:12 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.3.342.0; Thu, 20 Aug 2015
	14:55:12 +0200
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id A9AC69C68B; 
	Thu, 20 Aug 2015 14:55:12 +0200 (CEST)
From: Olof Johansson <olof.johansson@axis.com>
To: Michael Wood <michael.g.wood@intel.com>,
	<bitbake-devel@lists.openembedded.org>
In-Reply-To: <6327c2465f573e6332219c62c1a9b3d8323cfb50.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
	<6327c2465f573e6332219c62c1a9b3d8323cfb50.1439915029.git.michael.g.wood@intel.com>
Date: Thu, 20 Aug 2015 14:55:12 +0200
Message-ID: <1440074510-sup-9447@axis.com>
User-Agent: Sup/0.20.0
MIME-Version: 1.0
Subject: Re: [PATCH 12/14] bitbake: toaster logger: fix pylint issues
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
X-List-Received-Date: Thu, 20 Aug 2015 12:55:21 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Excerpts from Michael Wood's message of 2015-08-18 18:28:58 +0200:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
> 
> This patch fixes pylint issues in the toaster build data logger,
> toasterui. The following types of warnings are touched here:
> 
> * fixing imports
> * unused variables are set to _
> * logger calls now use lazy evaluation instead of formatting
> the string
> * correct whitespace identation
> * removes unneeded "pass" statements, and extra parantheses
> * disable specific pylint warnings when decideing to override
> them

This change causes the following RuntimeError exception, when running bitbake
(any bitbake command):

$ python --version
Python 2.7.9
$ bitbake
Traceback (most recent call last):
  File ".../poky/bitbake/bin/bitbake", line 44, in <module>
    sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),
  File ".../poky/bitbake/lib/bb/cookerdata.py", line 37, in __init__
    self.options, targets = self.parseCommandLine(argv)
  File ".../poky/bitbake/lib/bb/main.py", line 178, in parseCommandLine
    valid_uis = list_extension_modules(bb.ui, 'main')
  File ".../poky/bitbake/lib/bb/main.py", line 62, in list_extension_modules
    module = __import__(pkg.__name__, fromlist=[modulename])
  File ".../poky/bitbake/lib/bb/ui/buildinfohelper.py", line 44, in <module>
    from bldcontrol.models import BuildEnvironment, BuildRequest
  File ".../poky/bitbake/lib/toaster/bldcontrol/models.py", line 3, in <module>
    from orm.models import Project, ProjectLayer, ProjectVariable, ProjectTarget, Build
  File ".../poky/bitbake/lib/toaster/orm/models.py", line 56, in <module>
    class ToasterSetting(models.Model):
  File "/usr/lib/python2.7/dist-packages/django/db/models/base.py", line 283, in __new__
    new_class._meta.apps.register_model(new_class._meta.app_label, new_class)
  File "/usr/lib/python2.7/dist-packages/django/apps/registry.py", line 221, in register_model
    (model_name, app_label, app_models[model_name], model))
RuntimeError: Conflicting 'toastersetting' models in application 'orm': <class 'toaster.orm.models.ToasterSetting'> and <class 'orm.models.ToasterSetting'>.

Even though .../poky/bitbake/lib is already in the sys.path,
.../poky/bitbake/lib/toaster is also added, which seem to be the cause of this
issue.

I'm a bit surprised that this kind of change causes issues for use of bitbake
not related to toaster.

-- 
olof johansson

