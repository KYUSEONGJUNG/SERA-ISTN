
    if (!String.isNullOrEmpty) {
        String.isNullOrEmpty = function(val){
            return !val;
        };
    }

    if (!String.isNull) {
        String.isNull = function(val){
            return val === undefined || val === null;
        };
    }

    if (!String.getValue) {
        String.getValue = function(val, defVal){
            return String.isNullOrEmpty(val) ? defVal : val;
        };
    }

    if (!String.prototype.trim) {
        String.prototype.trim = function(){
            return this.replace(/^\s+|\s+$/g, '');
        };
    }

    if (!String.prototype.ltrim) {
        String.prototype.ltrim = function(){
            return this.replace(/^\s+/, '');
        };
    }

    if (!String.prototype.rtrim) {
        String.prototype.rtrim = function(){
            return this.replace(/\s+$/, '');
        };
    }

    if (!String.prototype.equal) {
        String.prototype.equal = function(val){
            return String.isNullOrEmpty(this) ? false : (this.toString() === val);
        };
    }

    if (!String.prototype.equalAny) {
        String.prototype.equalAny = function(vals){
            if (!vals) { return false; }
            var thisVal = this.toString();
            var len = vals.length;
            for (var i=0; i< len; i++) {
                if (thisVal == vals[i]) {
                    return true;
                }
            }
            thisVal = null;
            return false;
        };
    }

    if (!String.prototype.toBool) {
        String.prototype.toBool = function(){
            if (String.isNullOrEmpty(this)) { return false; }
            var val = this.toLowerCase();
            return (val.equal('true') || val.equal('1') || val.equal('y') || val.equal('t') || val.equal('checked') ||
                val.equal('required') || val.equal('disabled') || val.equal('readonly')) ? true : false;
        };
    }

    if (!String.prototype.toCamel) {
        String.prototype.toCamel = function(){
            return str.replace(/(\-[a-z])/g, function(g) { return g[1].toUpperCase().replace('-', ''); });
        };
    }

    if (!String.prototype.contains) {
        String.prototype.contains = function(val, position){
            return this.includes(val, position);
        };
    }

    if (!String.prototype.extract) {
        String.prototype.extract = function(start, end){
            var re = new RegExp(`${start}([^}]+)${end}`, 'g');
            var results = [];
            this.toString().replace(re, function($0, $1) { results.push($1); });
            return results;
        };
    }

    if (!String.prototype.containsAny) {
        String.prototype.containsAny = function(vals){
            if (!vals) { return false; }
            var len = vals.length;
            for (var i = 0; i < len; i++) {
                if (this.contains(vals[i])) {
                    return true;
                }
            }
            return false;
        };
    }

    if (!String.prototype.containsAll) {
        String.prototype.containsAll = function(vals){
            if (!vals) { return false; }
            var len = vals.length;
            for (var i = 0; i < len; i++) {
                if (!this.contains(vals[i])) {
                    return false;
                }
            }
            return true;
        };
    }

    if (!String.prototype.lpad) {
        String.prototype.lpad = function(len, char) {
            len = len >> 0; // floor if number or convert non-number to 0;
            char = String(char || ' ');
            if (this.length > len) {
                return String(this);
            } else {
                len = len - this.length;
                if (len > char.length) {
                    char += char.repeat(len / char.length);
                }
                return char.slice(0, len) + String(this);
            }
        };
    }

    if (!String.prototype.rpad) {
        String.prototype.rpad = function(len, char){
            len = len >> 0; // floor if number or convert non-number to 0;
            char = String(char || ' ');
            if (this.length > len) {
                return String(this);
            } else {
                len = len - this.length;
                if (len > char.length) {
                    char += char.repeat(len / char.length);
                }
                return String(this) + char.slice(0, len);
            }
        };
    }

    if (!String.prototype.toDate) {
        String.prototype.toDate = function(format) {
            return (SBUxG.moment(this.toString(), format.toUpperCase()))._d;
        };
    }

    if (!Array.isNullOrEmpty) {
        Array.isNullOrEmpty = function(val){
            return !(val && Array.isArray(val) && val.length);
        };
    }

    if (!Array.prototype.contains) {
        Array.prototype.contains = function(partial, strict){
            var len = this.length;
            for (var i = 0; i < len; i++) {
                if (!strict && this[i].contains(partial)){
                    return true;
                }
                if (strict && this[i] === partial) {
                    return true;
                }
            }
            return false;
        };
    }

    if (!Array.prototype.some) {
        Array.prototype.some = function(callback){
            var len = this.length;
            for (var i = 0; len; i++) {
                if (callback(i, this[i], this)) {
                    return true;
                }
            }
            return false;
        };
    }

    if (!Array.prototype.someNotEmpty) {
        Array.prototype.someNotEmpty = function(){
            var len = this.length;
            for (var i = 0; len; i++) {
                if (this[i]) {
                    return true;
                }
            }
            return false;
        };
    }

    if (!Array.prototype.forEach) {
        Array.prototype.forEach = function(fn, scope) {
            var len = this.length;
            for (var i = 0; len; i++) {
                fn.call(scope, this[i], i, this);
            }
        };
    }

    if (!Number.isNullOrEmpty) {
        Number.isNullOrEmpty = function(val){
            return !val;
        };
    }

    if (!Number.getValue) {
        Number.getValue = function(val, defVal){
            return Number.isNullOrEmpty(val) ? defVal : val;
        };
    }

    if (!Number.prototype.equal) {
        Number.prototype.equal = function(val){
            return this.valueOf() === val;
        };
    }

    if (!Number.prototype.equalAny) {
        Number.prototype.equalAny = function(vals){
            if (!vals) { return false; }

            var thisVal = this.valueOf();
            var len = vals.length;
            for (var i = 0; len; i++) {
                if (thisVal === vals[i]) {
                    return true;
                }
            }
            return false;
        };
    }

    if (!Date.prototype.toFormatString) {
        Date.prototype.toFormatString = function(format){
            return SBUxG.moment(this).format(format.toUpperCase());
        };
    }

    if (!Boolean.isNullOrEmpty) {
        Boolean.isNullOrEmpty = function(val) {
            return val === null || val === undefined;
        };
    }

    if (!Boolean.getValue) {
        Boolean.getValue = function(val, defVal){
            return Boolean.isNullOrEmpty(val) ? defVal : val;
        };
    }