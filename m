Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3A5F565CBC
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Aug 2015 21:06:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t7KL6jDO007230; Thu, 20 Aug 2015 22:06:45 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DK-e2PokUV_u; Thu, 20 Aug 2015 22:06:45 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t7KL6SFM007215
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 20 Aug 2015 22:06:40 +0100
Message-ID: <1440104788.12105.161.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Olof Johansson <olof.johansson@axis.com>, "Eggleton, Paul"
	<paul.eggleton@intel.com>
Date: Thu, 20 Aug 2015 22:06:28 +0100
In-Reply-To: <1440074510-sup-9447@axis.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
	<6327c2465f573e6332219c62c1a9b3d8323cfb50.1439915029.git.michael.g.wood@intel.com>
	<1440074510-sup-9447@axis.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Thu, 20 Aug 2015 21:06:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2015-08-20 at 14:55 +0200, Olof Johansson wrote:
> Excerpts from Michael Wood's message of 2015-08-18 18:28:58 +0200:
> > From: Alexandru DAMIAN <alexandru.damian@intel.com>
> > 
> > This patch fixes pylint issues in the toaster build data logger,
> > toasterui. The following types of warnings are touched here:
> > 
> > * fixing imports
> > * unused variables are set to _
> > * logger calls now use lazy evaluation instead of formatting
> > the string
> > * correct whitespace identation
> > * removes unneeded "pass" statements, and extra parantheses
> > * disable specific pylint warnings when decideing to override
> > them
> 
> This change causes the following RuntimeError exception, when running bitbake
> (any bitbake command):
> 
> $ python --version
> Python 2.7.9
> $ bitbake
> Traceback (most recent call last):
>   File ".../poky/bitbake/bin/bitbake", line 44, in <module>
>     sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),
>   File ".../poky/bitbake/lib/bb/cookerdata.py", line 37, in __init__
>     self.options, targets = self.parseCommandLine(argv)
>   File ".../poky/bitbake/lib/bb/main.py", line 178, in parseCommandLine
>     valid_uis = list_extension_modules(bb.ui, 'main')
>   File ".../poky/bitbake/lib/bb/main.py", line 62, in list_extension_modules
>     module = __import__(pkg.__name__, fromlist=[modulename])
>   File ".../poky/bitbake/lib/bb/ui/buildinfohelper.py", line 44, in <module>
>     from bldcontrol.models import BuildEnvironment, BuildRequest
>   File ".../poky/bitbake/lib/toaster/bldcontrol/models.py", line 3, in <module>
>     from orm.models import Project, ProjectLayer, ProjectVariable, ProjectTarget, Build
>   File ".../poky/bitbake/lib/toaster/orm/models.py", line 56, in <module>
>     class ToasterSetting(models.Model):
>   File "/usr/lib/python2.7/dist-packages/django/db/models/base.py", line 283, in __new__
>     new_class._meta.apps.register_model(new_class._meta.app_label, new_class)
>   File "/usr/lib/python2.7/dist-packages/django/apps/registry.py", line 221, in register_model
>     (model_name, app_label, app_models[model_name], model))
> RuntimeError: Conflicting 'toastersetting' models in application 'orm': <class 'toaster.orm.models.ToasterSetting'> and <class 'orm.models.ToasterSetting'>.
> 
> Even though .../poky/bitbake/lib is already in the sys.path,
> .../poky/bitbake/lib/toaster is also added, which seem to be the cause of this
> issue.
> 
> I'm a bit surprised that this kind of change causes issues for use of bitbake
> not related to toaster.

We're all a bit surprised. Its a nasty effect of Pauls recent "list all
the modules in bitbake --help" change :(.

Randy's sent I patch I've merged which at least bandaids this issue...

Cheers,

Richard


