Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T21Ja-0001NM-Ld for bitbake-devel@lists.openembedded.org;
	Thu, 16 Aug 2012 16:44:51 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7GEWsuX031539;
	Thu, 16 Aug 2012 15:32:54 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 31058-05; Thu, 16 Aug 2012 15:32:49 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7GEWkYD031533
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 16 Aug 2012 15:32:47 +0100
Message-ID: <1345127564.14667.68.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Seebach <peter.seebach@windriver.com>
Date: Thu, 16 Aug 2012 15:32:44 +0100
In-Reply-To: <3ace2a7bb6a6c03f8e359774caf2f14ae71ee8cd.1345079338.git.peter.seebach@windriver.com>
References: <cover.1345079338.git.peter.seebach@windriver.com>
	<3ace2a7bb6a6c03f8e359774caf2f14ae71ee8cd.1345079338.git.peter.seebach@windriver.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] data_smart.py: track file inclusion and variable modifications
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
X-List-Received-Date: Thu, 16 Aug 2012 14:44:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-08-15 at 20:14 -0500, Peter Seebach wrote:
> It is often the case that bitbake variables have values which
> strike the user as wrong, but finding out how they got that way
> can be gratuitously complicated.
> 
> This patch adds two levels of tracking. First, file inclusions
> are recorded, so the system can offer a tree structure showing
> which files were processed, and which other files they included.
> 
> Second, variable assignments, flag settings, and such are recorded
> with source information showing which file and line, or which block
> of Python code, produced each change.
> 
> This information is then used in the bitbake -e output to provide
> a usable history.
> 
> For variables:
> 1.  We create a history dict in the data_smart object, the
> members of which are lists of tuples.  It's three, count them,
> THREE unrelated data types in a single object!

Do we really need comments like "count them" in the commit message?

> 2.  There is an eventLog(...) function which allows recording
> things which happen to variables.
> 3.  setVar and friends are updated to take optional arguments
> indicating where a change occurred, and optional information
> about how to describe the change.
> 4.  We log pretty much everything if logging is enabled.
> 5.  You can query the history of a thing with data.getHistory(var)
> 
> In addition to file and line (which will be inferred to be
> "the calling Python code" if file is None), you can specify
> the operation to report and the value to report. This is used
> because append operations would otherwise report the entire
> new value after the append, which is almost never what you
> want.
> 
> The special file name 'Ignore' indicates that an event need
> not be logged.

This isn't particularly pythonic but I'm not going to lose sleep over
it.

> 
> For file inclusion:
> The file inclusion code maintains a stack of files in process,
> and creates a tree structure reflecting those changes. This is
> also attached to bitbake -e output.
> 
> Tracking must be specifically turned on.  If it's not, the
> history object is a single empty table (cheap) and the calls
> to eventLog() and extra argument passing are also probably
> quite cheap.  As a proof of concept, the showEnvironment function
> used by bitbake -e now uses this if available.
> 
> Signed-off-by: Peter Seebach <peter.seebach@windriver.com>
> ---
>  lib/bb/cooker.py                     |    2 +
>  lib/bb/data.py                       |   65 ++++++++++---
>  lib/bb/data_smart.py                 |  173 +++++++++++++++++++++++++++-------
>  lib/bb/parse/__init__.py             |    6 +-
>  lib/bb/parse/ast.py                  |   70 ++++++++------
>  lib/bb/parse/parse_py/ConfHandler.py |    4 +-
>  6 files changed, 239 insertions(+), 81 deletions(-)
> 
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 23fffc9..8d59774 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -830,6 +830,8 @@ class BBCooker:
>  
>      def parseConfigurationFiles(self, prefiles, postfiles):
>          data = self.configuration.data
> +        if self.configuration.show_environment:
> +            data.enableTracking()
>          bb.parse.init_parser(data)
>  
>          # Parse files for loading *before* bitbake.conf and any includes
> diff --git a/lib/bb/data.py b/lib/bb/data.py
> index 5b7a092..a762a40 100644
> --- a/lib/bb/data.py
> +++ b/lib/bb/data.py
> @@ -74,14 +74,22 @@ def createCopy(source):
>      """
>      return source.createCopy()
>  
> +# These are used in dataSmart, here as protection against KeyErrors.
> +def enableTracking():
> +    pass
> +
> +def disableTracking():
> +    pass
> +

Where would these get called from that would trigger a keyerror?


>  def initVar(var, d):
>      """Non-destructive var init for data structure"""
>      d.initVar(var)
>  
> 
> -def setVar(var, value, d):
> +def setVar(var, value, d, filename = None, lineno = None):
>      """Set a variable to a given value"""
> -    d.setVar(var, value)
> +    filename, lineno = d.infer_file_and_line(filename, lineno)
> +    d.setVar(var, value, filename, lineno)
>  

Changing any of these in data.py looks like a pointless waste of time.
The parser should be calling the object (dataSmart) variants and that is
now the preferred mechanism. If some old user does call here, the
parameters will be unset and the dataSmart setVar will call
infer_file_and_line for us anyway.

So in summary, I don't think any of these changes to data.py are
particularly useful.

>  def getVar(var, d, exp = 0):
> @@ -89,27 +97,31 @@ def getVar(var, d, exp = 0):
>      return d.getVar(var, exp)
>  
> 
> -def renameVar(key, newkey, d):
> +def renameVar(key, newkey, d, filename = None, lineno = None):
>      """Renames a variable from key to newkey"""
> -    d.renameVar(key, newkey)
> +    filename, lineno = d.infer_file_and_line(filename, lineno)
> +    d.renameVar(key, newkey, filename, lineno)
>  
> -def delVar(var, d):
> +def delVar(var, d, filename = None, lineno = None):
>      """Removes a variable from the data set"""
> -    d.delVar(var)
> +    filename, lineno = d.infer_file_and_line(filename, lineno)
> +    d.delVar(var, filename, lineno)
>  
> -def setVarFlag(var, flag, flagvalue, d):
> +def setVarFlag(var, flag, flagvalue, d, filename = None, lineno = None):
>      """Set a flag for a given variable to a given value"""
> -    d.setVarFlag(var, flag, flagvalue)
> +    filename, lineno = d.infer_file_and_line(filename, lineno)
> +    d.setVarFlag(var, flag, flagvalue, filename, lineno)
>  
>  def getVarFlag(var, flag, d):
>      """Gets given flag from given var"""
>      return d.getVarFlag(var, flag)
>  
> -def delVarFlag(var, flag, d):
> +def delVarFlag(var, flag, d, filename = None, lineno = None):
>      """Removes a given flag from the variable's flags"""
> -    d.delVarFlag(var, flag)
> +    filename, lineno = d.infer_file_and_line(filename, lineno)
> +    d.delVarFlag(var, flag, filename, lineno)
>  
> -def setVarFlags(var, flags, d):
> +def setVarFlags(var, flags, d, filename = None, lineno = None):
>      """Set the flags for a given variable
>  
>      Note:
> @@ -117,15 +129,17 @@ def setVarFlags(var, flags, d):
>          flags. Think of this method as
>          addVarFlags
>      """
> -    d.setVarFlags(var, flags)
> +    filename, lineno = d.infer_file_and_line(filename, lineno)
> +    d.setVarFlags(var, flags, filename, lineno)
>  
>  def getVarFlags(var, d):
>      """Gets a variable's flags"""
>      return d.getVarFlags(var)
>  
> -def delVarFlags(var, d):
> +def delVarFlags(var, d, filename = None, lineno = None):
>      """Removes a variable's flags"""
> -    d.delVarFlags(var)
> +    filename, lineno = d.infer_file_and_line(filename, lineno)
> +    d.delVarFlags(var, filename, lineno)

So all the above can be dropped.

>  def keys(d):
>      """Return a list of keys in d"""
> @@ -195,6 +209,13 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
>  
>      if all:
>          commentVal = re.sub('\n', '\n#', str(oval))
> +        history = d.getHistory(var)
> +        if history:
> +            o.write('#\n# %s [%d]\n' % (var, len(history)))
> +            for events in history:
> +                events = (events[0], events[1], events[2], re.sub('\n', '\n#     ', str(events[3])))
> +                o.write('#   %s %s:%s:\n#     <%s>\n' % events)
> +            o.write('#\n')
>          o.write('# %s=%s\n' % (var, commentVal))
>  
>      if (var.find("-") != -1 or var.find(".") != -1 or var.find('{') != -1 or var.find('}') != -1 or var.find('+') != -1) and not all:
> @@ -232,10 +253,26 @@ def emit_env(o=sys.__stdout__, d = init(), all=False):
>      isfunc = lambda key: bool(d.getVarFlag(key, "func"))
>      keys = sorted((key for key in d.keys() if not key.startswith("__")), key=isfunc)
>      grouped = groupby(keys, isfunc)
> +    # Include history!
> +    if d.tracking():
> +        o.write('#\n# INCLUDE HISTORY:\n#\n')
> +        emit_history(o, d.getIncludeHistory())
> +        
>      for isfunc, keys in grouped:
>          for key in keys:
>              emit_var(key, o, d, all and not isfunc) and o.write('\n')
>  
> +def emit_history(o, h, depth = 0):
> +    if not h:
> +        return
> +    for event in h:
> +        o.write("# %*s%s" % (depth * 2, "", event[0]))
> +        if event[1]:
> +            o.write(" includes:\n")
> +            emit_history(o, event[1], depth + 1)
> +        else:
> +            o.write("\n")
> +
>  def exported_keys(d):
>      return (key for key in d.keys() if not key.startswith('__') and
>                                        d.getVarFlag(key, 'export') and
> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> index 31216e0..a128914 100644
> --- a/lib/bb/data_smart.py
> +++ b/lib/bb/data_smart.py
> @@ -28,7 +28,9 @@ BitBake build tools.
>  # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>  # Based on functions from the base bb module, Copyright 2003 Holger Schurig
>  
> +import traceback
>  import copy, re
> +import sys
>  from collections import MutableMapping
>  import logging
>  import hashlib
> @@ -114,13 +116,51 @@ class ExpansionError(Exception):
>  class DataSmart(MutableMapping):
>      def __init__(self, special = COWDictBase.copy(), seen = COWDictBase.copy() ):
>          self.dict = {}
> +        self.history = {}
> +        self.include_history = []
> +        self.include_stack = [(-1, self.include_history)]
>  
>          # cookie monster tribute
>          self._special_values = special
>          self._seen_overrides = seen
> +        self._tracking_enabled = False
>  
>          self.expand_cache = {}
>  
> +    def includeLog(self, filename):
> +        """includeLog(included_file) shows that the file was included
> +        by the currently-processed file or context."""
> +        if self._tracking_enabled:
> +            event = (filename, [])
> +            position = (len(self.include_stack[-1][1]), event[1])
> +            self.include_stack[-1][1].append(event)
> +            self.include_stack.append(position)
> +
> +    def includeLogDone(self, filename):
> +        if self._tracking_enabled:
> +            if len(self.include_stack) > 1:
> +                self.include_stack.pop()
> +            else:
> +                bb.warn("Uh-oh:  includeLogDone(%s) tried to empty the stack." % filename)

There has to be a better way to write code to do this. This looks
horrible.


> +    def getIncludeHistory(self):
> +        return self.include_history
> +
> +    def tracking(self):
> +        return self._tracking_enabled
> +
> +    def enableTracking(self):
> +        self._tracking_enabled = True
> +
> +    def disableTracking(self):
> +        self._tracking_enabled = False
> +
> +    def eventLog(self, var, event, value, filename = None, lineno = None):
> +        if self._tracking_enabled and filename != 'Ignore':
> +            if var not in self.history:
> +                self.history[var] = []
> +            self.history[var].append((event, filename, lineno, value))
> +
>      def expandWithRefs(self, s, varname):
>  
>          if not isinstance(s, basestring): # sanity check
> @@ -153,6 +193,14 @@ class DataSmart(MutableMapping):
>      def expand(self, s, varname = None):
>          return self.expandWithRefs(s, varname).value
>  
> +    # Figure out how to describe the caller when file/line weren't
> +    # specified.
> +    def infer_file_and_line(self, filename, lineno):
> +        details = lineno
> +        if self._tracking_enabled and not filename and filename != 'Ignore':
> +            filename, lineno, func, line = traceback.extract_stack(limit=3)[0]
> +            details = "%d [%s]" % (lineno, func)
> +        return filename, details
>  
>      def finalize(self):
>          """Performs final steps upon the datastore, including application of overrides"""
> @@ -186,10 +234,14 @@ class DataSmart(MutableMapping):
>              for var in vars:
>                  name = var[:-l]
>                  try:
> -                    self.setVar(name, self.getVar(var, False))
> -                    self.delVar(var)
> -                except Exception:
> -                    logger.info("Untracked delVar")
> +                    # Move the history of the override into the history of
> +                    # the overridden:
> +                    for event in self.getHistory(var):
> +                        self.eventLog(name, 'override:%s' % o, event[3], event[1], event[2])
> +                    self.setVar(name, self.getVar(var, False), 'Ignore')
> +                    self.delVar(var, 'Ignore')
> +                except Exception, e:
> +                    logger.info("Untracked delVar %s: %s" % (var, e))
>  
>          # now on to the appends and prepends
>          for op in __setvar_keyword__:
> @@ -210,16 +262,17 @@ class DataSmart(MutableMapping):
>                          if op == "_append":
>                              sval = self.getVar(append, False) or ""
>                              sval += a
> -                            self.setVar(append, sval)
> +                            self.setVar(append, sval, 'Ignore')
>                          elif op == "_prepend":
>                              sval = a + (self.getVar(append, False) or "")
> -                            self.setVar(append, sval)
> +                            self.setVar(append, sval, 'Ignore')
>  
>                      # We save overrides that may be applied at some later stage
> +                    # ... but we don't need to report on this.
>                      if keep:
> -                        self.setVarFlag(append, op, keep)
> +                        self.setVarFlag(append, op, keep, 'Ignore')
>                      else:
> -                        self.delVarFlag(append, op)
> +                        self.delVarFlag(append, op, 'Ignore')
>  
>      def initVar(self, var):
>          self.expand_cache = {}
> @@ -247,7 +300,15 @@ class DataSmart(MutableMapping):
>          else:
>              self.initVar(var)
>  
> -    def setVar(self, var, value):
> +    # In some cases, we want to set a value, but only record part of it;
> +    # for instance, when appending something, we want to record what we
> +    # appended, not what the complete value of the now-appended value.
> +    # This becomes especially obvious when looking at the output for
> +    # BBCLASSEXTEND. "details", if provided, replace the variable value
> +    # in the log.
> +
> +    def setVar(self, var, value, filename = None, lineno = None, op = 'set', details = None):


As a function prototype, this scares me and shouts that there is
something going wrong here. The conversion of lineno to details and back
under a variety of different circumstances doesn't seem particularly
elegant or easy to understand.

Also, I want to hightlight that these changes effectively set our data
API in stone, making it effectively impossible to ever add sensible
external facing API changes. We should really change all these calls to
be named parameters so it doesn't totally freeze the API. I hate having
to do that but I hate the alternatives more.


> +        filename, lineno = self.infer_file_and_line(filename, lineno)
>          self.expand_cache = {}
>          match  = __setvar_regexp__.match(var)
>          if match and match.group("keyword") in __setvar_keyword__:
> @@ -255,8 +316,13 @@ class DataSmart(MutableMapping):
>              keyword = match.group("keyword")
>              override = match.group('add')
>              l = self.getVarFlag(base, keyword) or []
> -            l.append([value, override])
> -            self.setVarFlag(base, keyword, l)
> +            # Compute new details: This is what we're actually appending.
> +            details = [value, override]
> +            l.append(details)
> +            # Log the details using the keyword as the op name, instead
> +            # of logging the entire new value as a flag change.
> +            self.setVarFlag(base, keyword, l, 'Ignore')
> +            self.eventLog(base, keyword, details, filename, lineno)
>  
>              # todo make sure keyword is not __doc__ or __module__
>              # pay the cookie monster
> @@ -281,6 +347,12 @@ class DataSmart(MutableMapping):
>  
>          # setting var
>          self.dict[var]["content"] = value
> +        self.eventLog(var, op, details or value, filename, lineno)
> +
> +    def getHistory(self, var):
> +        if var in self.history:
> +            return self.history[var]
> +        return []
>  
>      def getVar(self, var, expand=False, noweakdefault=False):
>          value = self.getVarFlag(var, "content", False, noweakdefault)
> @@ -290,13 +362,14 @@ class DataSmart(MutableMapping):
>              return self.expand(value, var)
>          return value
>  
> -    def renameVar(self, key, newkey):
> +    def renameVar(self, key, newkey, filename = None, lineno = None):
>          """
>          Rename the variable key to newkey
>          """
> +        filename, lineno = self.infer_file_and_line(filename, lineno)
>          val = self.getVar(key, 0)
>          if val is not None:
> -            self.setVar(newkey, val)
> +            self.setVar(newkey, val, filename, lineno, 'rename-create')
>  
>          for i in ('_append', '_prepend'):
>              src = self.getVarFlag(key, i)
> @@ -305,34 +378,40 @@ class DataSmart(MutableMapping):
>  
>              dest = self.getVarFlag(newkey, i) or []
>              dest.extend(src)
> -            self.setVarFlag(newkey, i, dest)
> +            self.setVarFlag(newkey, i, dest, filename, lineno, 'rename')
>  
>              if i in self._special_values and key in self._special_values[i]:
>                  self._special_values[i].remove(key)
>                  self._special_values[i].add(newkey)
>  
> -        self.delVar(key)
> +        self.delVar(key, filename, lineno, 'rename-delete')
>  
> -    def appendVar(self, key, value):
> -        value = (self.getVar(key, False) or "") + value
> -        self.setVar(key, value)
> +    def appendVar(self, key, newValue, filename = None, lineno = None):
> +        filename, lineno = self.infer_file_and_line(filename, lineno)
> +        value = (self.getVar(key, False) or "") + newValue
> +        self.setVar(key, value, filename, lineno, 'append', newValue)
>  
> -    def prependVar(self, key, value):
> -        value = value + (self.getVar(key, False) or "")
> -        self.setVar(key, value)
> +    def prependVar(self, key, newValue, filename = None, lineno = None):
> +        filename, lineno = self.infer_file_and_line(filename, lineno)
> +        value = newValue + (self.getVar(key, False) or "")
> +        self.setVar(key, value, filename, lineno, 'prepend', newValue)
>  
> -    def delVar(self, var):
> +    def delVar(self, var, filename = None, lineno = None, op = 'del'):
> +        filename, lineno = self.infer_file_and_line(filename, lineno)
>          self.expand_cache = {}
>          self.dict[var] = {}
> +        self.eventLog(var, op, '', filename, lineno)
>          if '_' in var:
>              override = var[var.rfind('_')+1:]
>              if override and override in self._seen_overrides and var in self._seen_overrides[override]:
>                  self._seen_overrides[override].remove(var)
>  
> -    def setVarFlag(self, var, flag, flagvalue):
> +    def setVarFlag(self, var, flag, flagvalue, filename = None, lineno = None, op = 'set', details = None):
> +        filename, lineno = self.infer_file_and_line(filename, lineno)
>          if not var in self.dict:
>              self._makeShadowCopy(var)
>          self.dict[var][flag] = flagvalue
> +        self.eventLog(var, '[flag %s] %s' % (flag, op), details or flagvalue, filename, lineno)
>  
>      def getVarFlag(self, var, flag, expand=False, noweakdefault=False):
>          local_var = self._findVar(var)
> @@ -346,31 +425,37 @@ class DataSmart(MutableMapping):
>              value = self.expand(value, None)
>          return value
>  
> -    def delVarFlag(self, var, flag):
> +    def delVarFlag(self, var, flag, filename = None, lineno = None):
>          local_var = self._findVar(var)
>          if not local_var:
>              return
>          if not var in self.dict:
>              self._makeShadowCopy(var)
>  
> +        filename, lineno = self.infer_file_and_line(filename, lineno)
> +        self.eventLog(var, 'del flag %s' % flag, '', filename, lineno)
>          if var in self.dict and flag in self.dict[var]:
>              del self.dict[var][flag]
>  
> -    def appendVarFlag(self, key, flag, value):
> -        value = (self.getVarFlag(key, flag, False) or "") + value
> -        self.setVarFlag(key, flag, value)
> +    def appendVarFlag(self, key, flag, newValue, filename = None, lineno = None):
> +        filename, lineno = self.infer_file_and_line(filename, lineno)
> +        value = (self.getVarFlag(key, flag, False) or "") + newValue
> +        self.setVarFlag(key, flag, value, filename, lineno, 'append', newValue)
>  
> -    def prependVarFlag(self, key, flag, value):
> -        value = value + (self.getVarFlag(key, flag, False) or "")
> -        self.setVarFlag(key, flag, value)
> +    def prependVarFlag(self, key, flag, newValue, filename = None, lineno = None):
> +        filename, lineno = self.infer_file_and_line(filename, lineno)
> +        value = newValue + (self.getVarFlag(key, flag, False) or "")
> +        self.setVarFlag(key, flag, value, filename, lineno, 'prepend', newValue)
>  
> -    def setVarFlags(self, var, flags):
> +    def setVarFlags(self, var, flags, filename = None, lineno = None, details = None):
> +        filename, lineno = self.infer_file_and_line(filename, lineno)
>          if not var in self.dict:
>              self._makeShadowCopy(var)
>  
>          for i in flags:
>              if i == "content":
>                  continue
> +            self.eventLog(var, 'set flag %s' % i, details or flags[i], filename, lineno)
>              self.dict[var][i] = flags[i]
>  
>      def getVarFlags(self, var):
> @@ -388,13 +473,15 @@ class DataSmart(MutableMapping):
>          return flags
>  
> 
> -    def delVarFlags(self, var):
> +    def delVarFlags(self, var, filename = None, lineno = None):
>          if not var in self.dict:
>              self._makeShadowCopy(var)
>  
>          if var in self.dict:
>              content = None
>  
> +            filename, lineno = self.infer_file_and_line(filename, lineno)
> +            self.eventLog(var, 'clear all flags', '', filename, lineno)
>              # try to save the content
>              if "content" in self.dict[var]:
>                  content  = self.dict[var]["content"]
> @@ -411,10 +498,25 @@ class DataSmart(MutableMapping):
>          # we really want this to be a DataSmart...
>          data = DataSmart(seen=self._seen_overrides.copy(), special=self._special_values.copy())
>          data.dict["_data"] = self.dict
> -
> +        if self._tracking_enabled:
> +            data._tracking_enabled = self._tracking_enabled
> +            data.history = copy.deepcopy(self.history)
> +            data.include_history = copy.deepcopy(self.include_history)
> +            data.include_stack = []
> +            oldref = self.include_history
> +            newref = data.include_history
> +            # Create corresponding references, if we can
> +            try:
> +                for item in self.include_stack:
> +                    if item[0] >= 0:
> +                        newref = newref[item[0]][1]
> +                    newevent = (item[0], newref)
> +                    data.include_stack.append(newevent)
> +            except Exception:
> +                sys.exc_clear()
>          return data
>  
> -    def expandVarref(self, variable, parents=False):
> +    def expandVarref(self, variable, parents=False, filename = None, lineno = None):
>          """Find all references to variable in the data and expand it
>             in place, optionally descending to parent datastores."""
>  
> @@ -423,12 +525,13 @@ class DataSmart(MutableMapping):
>          else:
>              keys = self.localkeys()
>  
> +        filename, lineno = self.infer_file_and_line(filename, lineno)
>          ref = '${%s}' % variable
>          value = self.getVar(variable, False)
>          for key in keys:
>              referrervalue = self.getVar(key, False)
>              if referrervalue and ref in referrervalue:
> -                self.setVar(key, referrervalue.replace(ref, value))
> +                self.setVar(key, referrervalue.replace(ref, value), filename, lineno, 'expandVarref')
>  
>      def localkeys(self):
>          for key in self.dict:
> diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
> index 7b9c47e..0ea6a55 100644
> --- a/lib/bb/parse/__init__.py
> +++ b/lib/bb/parse/__init__.py
> @@ -88,7 +88,11 @@ def handle(fn, data, include = 0):
>      """Call the handler that is appropriate for this file"""
>      for h in handlers:
>          if h['supports'](fn, data):
> -            return h['handle'](fn, data, include)
> +            data.includeLog(fn)
> +            try:
> +                return h['handle'](fn, data, include)
> +            finally:
> +                data.includeLogDone(fn)
>      raise ParseError("not a BitBake file", fn)
>  
>  def init(fn, data):
> diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
> index 86f9463..dbc2237 100644
> --- a/lib/bb/parse/ast.py
> +++ b/lib/bb/parse/ast.py
> @@ -69,7 +69,7 @@ class ExportNode(AstNode):
>          self.var = var
>  
>      def eval(self, data):
> -        data.setVarFlag(self.var, "export", 1)
> +        data.setVarFlag(self.var, "export", 1, self.filename, self.lineno)
>  
>  class DataNode(AstNode):
>      """
> @@ -91,33 +91,45 @@ class DataNode(AstNode):
>      def eval(self, data):
>          groupd = self.groupd
>          key = groupd["var"]
> +        op = 'set'
> +        details = None
>          if "exp" in groupd and groupd["exp"] != None:
> -            data.setVarFlag(key, "export", 1)
> +            data.setVarFlag(key, "export", 1, self.filename, self.lineno)
>          if "ques" in groupd and groupd["ques"] != None:
>              val = self.getFunc(key, data)
>              if val == None:
>                  val = groupd["value"]
> +                op = 'set?'
>          elif "colon" in groupd and groupd["colon"] != None:
>              e = data.createCopy()
>              bb.data.update_data(e)
>              val = e.expand(groupd["value"], key + "[:=]")
> +            op = 'immediate'
>          elif "append" in groupd and groupd["append"] != None:
>              val = "%s %s" % ((self.getFunc(key, data) or ""), groupd["value"])
> +            op = 'append'
> +            details = groupd["value"]
>          elif "prepend" in groupd and groupd["prepend"] != None:
>              val = "%s %s" % (groupd["value"], (self.getFunc(key, data) or ""))
> +            op = 'prepend'
> +            details = groupd["value"]
>          elif "postdot" in groupd and groupd["postdot"] != None:
>              val = "%s%s" % ((self.getFunc(key, data) or ""), groupd["value"])
> +            op = 'postdot'
> +            details = groupd["value"]
>          elif "predot" in groupd and groupd["predot"] != None:
>              val = "%s%s" % (groupd["value"], (self.getFunc(key, data) or ""))
> +            op = 'predot'
> +            details = groupd["value"]
>          else:
>              val = groupd["value"]
>  
>          if 'flag' in groupd and groupd['flag'] != None:
> -            data.setVarFlag(key, groupd['flag'], val)
> +            data.setVarFlag(key, groupd['flag'], val, self.filename, self.lineno, op)
>          elif groupd["lazyques"]:
> -            data.setVarFlag(key, "defaultval", val)
> +            data.setVarFlag(key, "defaultval", val, self.filename, self.lineno, op)
>          else:
> -            data.setVar(key, val)
> +            data.setVar(key, val, self.filename, self.lineno, op, details)
>  
>  class MethodNode(AstNode):
>      def __init__(self, filename, lineno, func_name, body):
> @@ -133,10 +145,10 @@ class MethodNode(AstNode):
>                  bb.methodpool.insert_method(funcname, text, self.filename)
>              anonfuncs = data.getVar('__BBANONFUNCS') or []
>              anonfuncs.append(funcname)
> -            data.setVar('__BBANONFUNCS', anonfuncs)
> +            data.setVar('__BBANONFUNCS', anonfuncs, self.filename, self.lineno)

filename/lineno info is not useful here (should be Invalid)

>          else:
> -            data.setVarFlag(self.func_name, "func", 1)
> -            data.setVar(self.func_name, '\n'.join(self.body))
> +            data.setVarFlag(self.func_name, "func", 1, self.filename, self.lineno)
> +            data.setVar(self.func_name, '\n'.join(self.body), self.filename, self.lineno)
>  
>  class PythonMethodNode(AstNode):
>      def __init__(self, filename, lineno, function, define, body):
> @@ -152,9 +164,9 @@ class PythonMethodNode(AstNode):
>          text = '\n'.join(self.body)
>          if not bb.methodpool.parsed_module(self.define):
>              bb.methodpool.insert_method(self.define, text, self.filename)
> -        data.setVarFlag(self.function, "func", 1)
> -        data.setVarFlag(self.function, "python", 1)
> -        data.setVar(self.function, text)
> +        data.setVarFlag(self.function, "func", 1, self.filename, self.lineno)
> +        data.setVarFlag(self.function, "python", 1, self.filename, self.lineno)
> +        data.setVar(self.function, text, self.filename, self.lineno)
>  
>  class MethodFlagsNode(AstNode):
>      def __init__(self, filename, lineno, key, m):
> @@ -166,16 +178,16 @@ class MethodFlagsNode(AstNode):
>          if data.getVar(self.key):
>              # clean up old version of this piece of metadata, as its
>              # flags could cause problems
> -            data.setVarFlag(self.key, 'python', None)
> -            data.setVarFlag(self.key, 'fakeroot', None)
> +            data.setVarFlag(self.key, 'python', None, self.filename, self.lineno)
> +            data.setVarFlag(self.key, 'fakeroot', None, self.filename, self.lineno)
>          if self.m.group("py") is not None:
> -            data.setVarFlag(self.key, "python", "1")
> +            data.setVarFlag(self.key, "python", "1", self.filename, self.lineno)
>          else:
> -            data.delVarFlag(self.key, "python")
> +            data.delVarFlag(self.key, "python", self.filename, self.lineno)
>          if self.m.group("fr") is not None:
> -            data.setVarFlag(self.key, "fakeroot", "1")
> +            data.setVarFlag(self.key, "fakeroot", "1", self.filename, self.lineno)
>          else:
> -            data.delVarFlag(self.key, "fakeroot")
> +            data.delVarFlag(self.key, "fakeroot", self.filename, self.lineno)
>  
>  class ExportFuncsNode(AstNode):
>      def __init__(self, filename, lineno, fns, classes):
> @@ -201,21 +213,21 @@ class ExportFuncsNode(AstNode):
>                      continue
>  
>                  if data.getVar(var):
> -                    data.setVarFlag(var, 'python', None)
> -                    data.setVarFlag(var, 'func', None)
> +                    data.setVarFlag(var, 'python', None, self.filename, self.lineno)
> +                    data.setVarFlag(var, 'func', None, self.filename, self.lineno)
>  
>                  for flag in [ "func", "python" ]:
>                      if data.getVarFlag(calledvar, flag):
> -                        data.setVarFlag(var, flag, data.getVarFlag(calledvar, flag))
> +                        data.setVarFlag(var, flag, data.getVarFlag(calledvar, flag), self.filename, self.lineno)
>                  for flag in [ "dirs" ]:
>                      if data.getVarFlag(var, flag):
> -                        data.setVarFlag(calledvar, flag, data.getVarFlag(var, flag))
> +                        data.setVarFlag(calledvar, flag, data.getVarFlag(var, flag), self.filename, self.lineno)
>  
>                  if data.getVarFlag(calledvar, "python"):
> -                    data.setVar(var, "    bb.build.exec_func('" + calledvar + "', d)\n")
> +                    data.setVar(var, "    bb.build.exec_func('" + calledvar + "', d)\n", self.filename, self.lineno)
>                  else:
> -                    data.setVar(var, "    " + calledvar + "\n")
> -                data.setVarFlag(var, 'export_func', '1')
> +                    data.setVar(var, "    " + calledvar + "\n", self.filename, self.lineno)
> +                data.setVarFlag(var, 'export_func', '1', self.filename, self.lineno)
>  
>  class AddTaskNode(AstNode):
>      def __init__(self, filename, lineno, func, before, after):
> @@ -229,11 +241,11 @@ class AddTaskNode(AstNode):
>          if self.func[:3] != "do_":
>              var = "do_" + self.func
>  
> -        data.setVarFlag(var, "task", 1)
> +        data.setVarFlag(var, "task", 1, self.filename, self.lineno)
>          bbtasks = data.getVar('__BBTASKS') or []
>          if not var in bbtasks:
>              bbtasks.append(var)
> -        data.setVar('__BBTASKS', bbtasks)
> +        data.setVar('__BBTASKS', bbtasks, self.filename, self.lineno)

filename/lineno info is not useful here (should be Invalid)

>  
>          existing = data.getVarFlag(var, "deps") or []
>          if self.after is not None:
> @@ -241,13 +253,13 @@ class AddTaskNode(AstNode):
>              for entry in self.after.split():
>                  if entry not in existing:
>                      existing.append(entry)
> -        data.setVarFlag(var, "deps", existing)
> +        data.setVarFlag(var, "deps", existing, self.filename, self.lineno)
>          if self.before is not None:
>              # set up things that depend on this func
>              for entry in self.before.split():
>                  existing = data.getVarFlag(entry, "deps") or []
>                  if var not in existing:
> -                    data.setVarFlag(entry, "deps", [var] + existing)
> +                    data.setVarFlag(entry, "deps", [var] + existing, self.filename, self.lineno)

filename/lineno info is not useful here (should be Invalid) or change
this to an append preserving the info.

>  
>  class BBHandlerNode(AstNode):
>      def __init__(self, filename, lineno, fns):
> @@ -258,7 +270,7 @@ class BBHandlerNode(AstNode):
>          bbhands = data.getVar('__BBHANDLERS') or []
>          for h in self.hs:
>              bbhands.append(h)
> -            data.setVarFlag(h, "handler", 1)
> +            data.setVarFlag(h, "handler", 1, self.filename, self.lineno)
>          data.setVar('__BBHANDLERS', bbhands)
>  
>  class InheritNode(AstNode):
> diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
> index 6f77bd4..4a1012e 100644
> --- a/lib/bb/parse/parse_py/ConfHandler.py
> +++ b/lib/bb/parse/parse_py/ConfHandler.py
> @@ -110,10 +110,10 @@ def handle(fn, data, include):
>          feeder(lineno, s, fn, statements)
>  
>      # DONE WITH PARSING... time to evaluate
> -    data.setVar('FILE', abs_fn)
> +    data.setVar('FILE', abs_fn, 'Ignore')
>      statements.eval(data)
>      if oldfile:
> -        data.setVar('FILE', oldfile)
> +        data.setVar('FILE', oldfile, 'Ignore')

I wonder if a _setVar() variant which behaves like 'Ignore' would be a
better way of doing this?

So I do like the intent of this series but I don't like the impact on
the code base and think it needs some work to improve readability at the
very least.

Cheers,

Richard



