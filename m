Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 36A7671395
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Sep 2014 22:08:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s83M8RO4001870; Wed, 3 Sep 2014 23:08:27 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id yC1S8lJgSRnm; Wed,  3 Sep 2014 23:08:27 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s83M8MnM001863
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 3 Sep 2014 23:08:23 +0100
Message-ID: <1409782104.12482.15.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Olof Johansson <olof.johansson@axis.com>
Date: Wed, 03 Sep 2014 23:08:24 +0100
In-Reply-To: <20140902082052.GB21392@axis.com>
References: <1409145892.5772.49.camel@ted> <20140902082052.GB21392@axis.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Wed, 03 Sep 2014 22:08:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2014-09-02 at 10:20 +0200, Olof Johansson wrote:
> On 14-08-27 15:24 +0200, Richard Purdie wrote:
> > Currently the output in the python task/function run files is rather
> > incomplete and effectively useless. This enhances the code to take
> > advantage of the bitbake's dependency tracking and extend the output to
> > include dependencies. This makes the files more usable for debugging
> > purposes. Since this only happens at python function execution time, the
> > overhead is minimal in the grand scheme of things.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > 
> ....
> > diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
> > index 3d776b3..91b1eb1 100644
> > --- a/bitbake/lib/bb/data.py
> > +++ b/bitbake/lib/bb/data.py
> ....
> > +def emit_func_python(func, o=sys.__stdout__, d = init()):
> > +    """Emits all items in the data store in a format such that it can be sourced by a shell."""
> > +
> > +    def write_func(func, o, call = False):
> > +        body = d.getVar(func, True)
> > +        if not body.startswith("def"):
> > +            body = _functionfmt.format(function=func, body=body)
> ....
> 
> With this change, we are seeing problems in certain cases when a python
> function (def foo():) is being resolved. d.getVar("foo") would return None
> and then fail from not having a startswith() method:
> 
> ERROR: Build of do_unpack failed
> ERROR: Traceback (most recent call last):
>   File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/build.py", line 497, in exec_task
>     return _exec_task(fn, task, d, quieterr)
>   File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/build.py", line 438, in _exec_task
>     exec_func(task, localdata)
>   File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/build.py", line 212, in exec_func
>     exec_func_python(func, d, runfile, cwd=adir)
>   File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/build.py", line 230, in exec_func_python
>     bb.data.emit_func_python(func, script, d)
>   File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/data.py", line 313, in emit_func_python
>     write_func(dep, o)
>   File "/var/opt/builds/olofjn/oe/master/bitbake/lib/bb/data.py", line 294, in write_func
>     if not body.startswith("def"):
> AttributeError: 'NoneType' object has no attribute 'startswith'
> 
> 
> Our qemu_%.bbappend contains the following:
> 
>     def _remove_git_submodule_file(filename):
>         import os
>     
>         if not os.path.isfile(filename):
>             return
>     
>         os.unlink(filename)
>     
>     do_unpack_append() {
>         _remove_git_submodule_file(d.getVar("S", True) + "/dtc/.git")
>         _remove_git_submodule_file(d.getVar("S", True) + "/pixman/.git")
>     }
> 
> Moving the function to within do_unpack_append would solve the problem.

We should probably put a safeguard in that code, if the function isn't
in the datastore, not to try and write it out, just pass over it. Its
either that, or pull it from the methodpool, which thinking about it,
may not be a bad idea since it is in there somewhere...

Cheers,

Richard


