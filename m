Return-Path: <olof.johansson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id A5A1C65C7B
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Sep 2014 08:21:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 47669180B8
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Sep 2014 10:20:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id YEdxtARaH3Nq for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Sep 2014 10:20:52 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id E6CC5180C7
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Sep 2014 10:20:52 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id C97E51028
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Sep 2014 10:20:52 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id BE362C31
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Sep 2014 10:20:52 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id BC0B43E048
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Sep 2014 10:20:52 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.3.342.0;
	Tue, 2 Sep 2014 10:20:52 +0200
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 856AF9C552; 
	Tue,  2 Sep 2014 10:20:52 +0200 (CEST)
Date: Tue, 2 Sep 2014 10:20:52 +0200
From: Olof Johansson <olof.johansson@axis.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Message-ID: <20140902082052.GB21392@axis.com>
References: <1409145892.5772.49.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1409145892.5772.49.camel@ted>
User-Agent: Mutt/1.5.23 (2014-03-12)
Subject: Re: [PATCH] build/data: Write out more complete python run files
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
X-List-Received-Date: Tue, 02 Sep 2014 08:21:06 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On 14-08-27 15:24 +0200, Richard Purdie wrote:
> Currently the output in the python task/function run files is rather
> incomplete and effectively useless. This enhances the code to take
> advantage of the bitbake's dependency tracking and extend the output to
> include dependencies. This makes the files more usable for debugging
> purposes. Since this only happens at python function execution time, the
> overhead is minimal in the grand scheme of things.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> 
....
> diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
> index 3d776b3..91b1eb1 100644
> --- a/bitbake/lib/bb/data.py
> +++ b/bitbake/lib/bb/data.py
....
> +def emit_func_python(func, o=sys.__stdout__, d = init()):
> +    """Emits all items in the data store in a format such that it can be sourced by a shell."""
> +
> +    def write_func(func, o, call = False):
> +        body = d.getVar(func, True)
> +        if not body.startswith("def"):
> +            body = _functionfmt.format(function=func, body=body)
....

With this change, we are seeing problems in certain cases when a python
function (def foo():) is being resolved. d.getVar("foo") would return None
and then fail from not having a startswith() method:

ERROR: Build of do_unpack failed
ERROR: Traceback (most recent call last):
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/build.py", line 497, in exec_task
    return _exec_task(fn, task, d, quieterr)
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/build.py", line 438, in _exec_task
    exec_func(task, localdata)
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/build.py", line 212, in exec_func
    exec_func_python(func, d, runfile, cwd=adir)
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/build.py", line 230, in exec_func_python
    bb.data.emit_func_python(func, script, d)
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/data.py", line 313, in emit_func_python
    write_func(dep, o)
  File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/data.py", line 294, in write_func
    if not body.startswith("def"):
AttributeError: 'NoneType' object has no attribute 'startswith'


Our qemu_%.bbappend contains the following:

    def _remove_git_submodule_file(filename):
        import os
    
        if not os.path.isfile(filename):
            return
    
        os.unlink(filename)
    
    do_unpack_append() {
        _remove_git_submodule_file(d.getVar("S", True) + "/dtc/.git")
        _remove_git_submodule_file(d.getVar("S", True) + "/pixman/.git")
    }

Moving the function to within do_unpack_append would solve the problem.

-- 
olofjn

