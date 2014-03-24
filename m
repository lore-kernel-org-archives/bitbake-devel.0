Return-Path: <olof.johansson@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id A94AF6F7C6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 12:45:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 45C672E409;
	Mon, 24 Mar 2014 13:45:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id XSOOLH5rzn5U; Mon, 24 Mar 2014 13:45:28 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id E90562E399;
	Mon, 24 Mar 2014 13:45:27 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id D0818E1B;
	Mon, 24 Mar 2014 13:45:27 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id C459BB74;
	Mon, 24 Mar 2014 13:45:27 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id C1E8934005;
	Mon, 24 Mar 2014 13:45:27 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.3.342.0; Mon, 24 Mar 2014
	13:45:27 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 82EAF9C29D; 
	Mon, 24 Mar 2014 13:45:27 +0100 (CET)
Date: Mon, 24 Mar 2014 13:45:27 +0100
From: Olof Johansson <olof.johansson@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20140324124527.GI16597@axis.com>
References: <cover.1392908060.git.pkj@axis.com>
	<c7f06c48293a2d7edc3894fe5259a8704afd1e17.1392908060.git.pkj@axis.com>
	<1393068245.5181.8.camel@ted> <20140320150345.GB951@axis.com>
	<1395328459.3808.180.camel@ted> <20140321082723.GC16597@axis.com>
	<1395483143.24232.16.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1395483143.24232.16.camel@ted>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: Peter Kjellerstedt <pkj@axis.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/1] bitbake: Disable pseudo in runfetchcmd()
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
X-List-Received-Date: Mon, 24 Mar 2014 12:45:32 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On 14-03-22 11:12 +0100, Richard Purdie wrote:
> On Fri, 2014-03-21 at 09:27 +0100, Olof Johansson wrote:
> > On 14-03-20 16:14 +0100, Richard Purdie wrote:
> > > The log helps immensely since it shows its "Failure expanding variable
> > > do_patch" so its not running do_patch, it is trying to expand the
> > > variable for some reason when writing the rpm in do_package_write_rpm. 
> > > 
> > > Are you generating some kind of srpm differently from the normal
> > > usecases?
> > 
> > No we don't, as far as I know (is there something I should look
> > for?). If this isn't something we are doing, what makes it a
> > problem for us is the fetching of kernel sources from git over
> > ssh with key authentication. Not sure how common that is.
> 
> Are you using the archiver classes?

> I'm wondering if
> 
> http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=2c7d20ce3849aba84e0552f0fc4bde649d96faa9
> 
> might resolve the issue.

We don't; grepping for 'archive' in our layer gives me zero hits.
And I can still reproduce the issue.

> Somehow you're referencing do_patch in the rpm write task and
> I'd like to figure out how. We should not be hitting the
> network during anything other than do_fetch...

I added an exit(1) in the git fetcher to get a traceback:

Traceback (most recent call last):
  File "/var/opt/builds/olofjn/oe/master/bitbake/bin/bitbake-worker", line 365, in <module>
    worker.serve()
  File "/var/opt/builds/olofjn/oe/master/bitbake/bin/bitbake-worker", line 267, in serve
    self.handle_item("runtask", self.handle_runtask)
  File "/var/opt/builds/olofjn/oe/master/bitbake/bin/bitbake-worker", line 283, in handle_item
    func(self.queue[(len(item) + 2):index])
  File "/var/opt/builds/olofjn/oe/master/bitbake/bin/bitbake-worker", line 317, in handle_runtask
    pid, pipein, pipeout = fork_off_task(self.cookercfg, self.data, self.workerdata, fn, task, taskname, appends, taskdepdata, quieterrors)
  File "/var/opt/builds/olofjn/oe/master/bitbake/bin/bitbake-worker", line 160, in fork_off_task
    the_data = bb.cache.Cache.loadDataFull(fn, appends, data)
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/cache.py", line 398, in loadDataFull
    bb_data = cls.load_bbfile(fn, appends, cfgData)
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/cache.py", line 673, in load_bbfile
    bb_data = parse.handle(bbfile, bb_data)
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/parse/__init__.py", line 99, in handle
    return h['handle'](fn, data, include)
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/parse/parse_py/BBHandler.py", line 169, in handle
    return ast.multi_finalize(fn, d)
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/parse/ast.py", line 386, in multi_finalize
    finalize(fn, d)
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/parse/ast.py", line 334, in finalize
    bb.parse.siggen.finalise(fn, d, variant)
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/siggen.py", line 139, in finalise
    taskdeps = self._build_data(fn, d)
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/siggen.py", line 92, in _build_data
    tasklist, gendeps, lookupcache = bb.data.generate_dependencies(d)
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/data.py", line 382, in generate_dependencies
    deps[task], values[task] = build_dependencies(task, keys, shelldeps, varflagsexcl, d)
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/data.py", line 329, in build_dependencies
    parsedvar = d.expandWithRefs(value, key)
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/data_smart.py", line 332, in expandWithRefs
    s = __expand_python_regexp__.sub(varparse.python_sub, s)
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/data_smart.py", line 129, in python_sub
    value = utils.better_eval(codeobj, DataContext(self.d))
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/utils.py", line 378, in better_eval
    return eval(source, get_context(), locals)
  File "do_patch", line 1, in <module>
  File "kernel-yocto.bbclass", line 2, in get_machine_branch
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/fetch2/__init__.py", line 1336, in __init__
    self.ud[url] = FetchData(url, d, localonly)
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/fetch2/__init__.py", line 1038, in __init__
    self.method.urldata_init(self, d)
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/fetch2/git.py", line 137, in urldata_init
    ud.revisions[name] = self.latest_revision(ud, d, name)
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/fetch2/__init__.py", line 1307, in latest_revision
    revs[key] = rev = self._latest_revision(ud, d, name)
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/fetch2/git.py", line 345, in _latest_revision
    output = self._lsremote(ud, d, search)
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/fetch2/git.py", line 329, in _lsremote
    exit(1)
  File "/usr/lib/python2.7/site.py", line 374, in __call__
    raise SystemExit(code)
SystemExit: 1
1NOTE: Tasks Summary: Attempted 373 tasks of which 372 didn't need to be rerun and all succeeded.


I also print out the tasklist (__BBTASKS) as seen in data.py's generate_dependencies:

ERROR: tasklist = ['do_patch', 'do_populate_sysroot',
    'do_populate_sysroot_setscene', 'do_listtasks', 'do_clean',
    'do_checkuri', 'do_checkuriall', 'do_fetchall', 'do_fetch',
    'do_unpack', 'do_configure', 'do_compile', 'do_install',
    'do_build', 'do_cleansstate', 'do_cleanall', 'do_package',
    'do_package_setscene', 'do_packagedata',
    'do_packagedata_setscene', 'do_package_write_rpm_setscene',
    'do_package_write_rpm', 'do_devshell', 'do_populate_lic',
    'do_populate_lic_setscene', 'do_deploy_setscene',
    'do_bundle_initramfs', 'do_compile_kernelmodules',
    'do_savedefconfig', 'do_menuconfig', 'do_diffconfig', 'do_strip',
    'do_sizecheck', 'do_uboot_mkimage', 'do_deploy',
    'do_kernel_configme', 'do_kernel_checkout',
    'do_kernel_link_vmlinux', 'do_validate_branches',
    'do_kernel_configcheck', 'do_kernel_link_vmlinuz']

I still don't get why do_patch is expanded, but afaict it tries
to do expansion of all of the tasks in __BBTASKS, and the mere
expansion of the do_patch variable triggers the fetcher to get
things from the network.


-- 
olofjn

