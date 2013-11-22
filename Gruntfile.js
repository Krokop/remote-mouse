module.exports = function(grunt) {
  grunt.initConfig({

    coffee: {

      dist: {
        expand: true,
        cwd: 'coffee',
        src: ['*.coffee', '**/*.coffee'],
        dest: 'js',
        ext: '.js'
      }
    },

    sass: {
      dist: {
        expand: true,
        cwd: 'coffee',
        src: ['*.scss', '**/*.scss'],
        dest: 'js',
        ext: '.css'
      }
    },

    watch: {
      coffee: {
        files: ['coffee/*.coffee', 'coffee/**/*.coffee'],
        tasks: ['coffee']
      },

      sass: {
        files: ['coffee/**/*.scss'],
        tasks: ['sass']
      },

      copy: {
        files: ['html/**'],
        tasks: ['copy:main']
      }

    },

    copy: {
      main: {
        files: [
          {expand: true, cwd: 'coffee/html', src: ['**'], dest: 'js/html'}
        ]
      }
    }

  });
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-copy');


  grunt.registerTask('run', ['coffee', 'sass', 'watch']);
  grunt.registerTask('default', ['run']);

};