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

    watch: {
      coffee: {
        files: ['coffee/*.coffee', 'coffee/**/*.coffee'],
        tasks: ['coffee']
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

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-copy');


  grunt.registerTask('run', ['coffee', 'copy', 'watch']);
  grunt.registerTask('default', ['run']);

};